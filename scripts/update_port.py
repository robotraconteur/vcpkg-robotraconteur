from pathlib import Path
import argparse
import re
import urllib
import urllib.request
import hashlib
import os


def main():
    
    parser = argparse.ArgumentParser(description="Update vcpkg port to new version")
    parser.add_argument("--port", type=str, default=None, help="The port to update")
    parser.add_argument("--src-repository", type=str, default=None, help="The source repository")
    parser.add_argument("--tag-name", type=str, default=None, help="The tag name. Must be semver based")

    args = parser.parse_args()

    tag_name = args.tag_name
    if tag_name is None:
        tag_name = os.environ["INPUT_TAG_NAME"]

    semver_regex = r"^v((?:0|[1-9]\d*)\.(?:0|[1-9]\d*)\.(?:0|[1-9]\d*))(?:(-(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$"

    tag_name_r = re.match(semver_regex,tag_name)

    port_name = args.port
    if port_name is None:
        port_name = os.environ["INPUT_PORT"]

    with open(f"ports/{port_name}/vcpkg.json", "r") as f:
        vcpkg_json = f.read()

    with open(f"ports/{port_name}/portfile.cmake", "r") as f:
        portfile = f.read()
    
    repo = args.src_repository
    if repo is None:
        repo = os.environ["INPUT_SOURCE_REPOSITORY"]

    tarball_url = f"https://github.com/{repo}/archive/{tag_name}.tar.gz"

    

    req = urllib.request.Request(tarball_url, headers={"Accept": "application/octet-stream"})
    response = urllib.request.urlopen(req)
    file_data = response.read()

    print("End download")

    tarball_sha512 = hashlib.sha512(file_data).hexdigest()
    

    print(tarball_sha512)

    
    vcpkg_ver =  tag_name_r.group(1) + tag_name_r.group(2)

    vcpkg_json2 = re.sub(r'("version-semver"\s*\:\s*)"([^"]+)"', f'\\g<1>"{vcpkg_ver}"', vcpkg_json, count=1)
    print(vcpkg_json2)

    portfile2 = re.sub(r"(vcpkg_from_github\([\w\s\/.\-]*\sREPO\s+)([\w]+\/[\w]+)",f"\\g<1>{repo}", portfile)
    portfile3 = re.sub(r"(vcpkg_from_github\([\w\s\/.\-]*\sREF\s+)([\w\-.]+)",f"\\g<1>{tag_name}", portfile2)
    portfile4 = re.sub(r"(vcpkg_from_github\([\w\s\/.\-]*\sSHA512\s+)([A-Za-z0-9]+)",f"\\g<1>{tarball_sha512}", portfile3)
    print(portfile4)

    with open(f"ports/{port_name}/vcpkg.json", "w") as f:
        f.write(vcpkg_json2)

    with open(f"ports/{port_name}/portfile.cmake", "w") as f:
        f.write(portfile4)




if __name__ == "__main__":
    main()
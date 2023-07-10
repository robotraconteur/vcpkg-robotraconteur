vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO robotraconteur/robotraconteur_companion
    REF v0.3.0
    SHA512 6ac59b8a9aa81a34649cd600a5ddb2fcfaecbf2cc28dc5a86391e3876bd9678d85b4f34deded438a20c8affc0631aa540bd99c1366f9e13f7c88216066fd930d
    HEAD_REF master
)

vcpkg_from_github(
    OUT_SOURCE_PATH ROBDEF_SOURCE_PATH
    REPO robotraconteur/robotraconteur_companion
    REF v0.3.0
    SHA512 6ac59b8a9aa81a34649cd600a5ddb2fcfaecbf2cc28dc5a86391e3876bd9678d85b4f34deded438a20c8affc0631aa540bd99c1366f9e13f7c88216066fd930d
    HEAD_REF master
)

file(COPY ${ROBDEF_SOURCE_PATH}/group1 DESTINATION ${SOURCE_PATH}/robdef/)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()

vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/RobotRaconteurCompanion" TARGET_PATH "share/RobotRaconteurCompanion")

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

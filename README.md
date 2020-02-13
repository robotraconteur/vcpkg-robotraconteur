# Robot Raconteur vcpkg overlay

This repository contains Robot Raconteur overlay ports and triplets for vcpkg. 

To build Robot Raconteur using vcpkg, first [install vcpkg](https://github.com/microsoft/vcpkg#quick-start), then:

Clone the `vcpkg-robotraconteur` overlay repo in the vcpkg directory:

```
git clone https://github.com/robotraconteur/vcpkg-robotraconteur.git
```

and build the library:

```
vcpkg --overlay-ports=vcpkg-robotraconteur\ports install robotraconteur
```

To build x64, use:

```
vcpkg --overlay-ports=vcpkg-robotraconteur\ports install robotraconteur:x64-windows
```

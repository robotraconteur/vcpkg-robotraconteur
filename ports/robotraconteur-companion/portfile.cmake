vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO robotraconteur/robotraconteur_companion
    REF "v${VERSION}"
    SHA512 9df5fc4afe635b86cf150e59f06a809b856f17921507e75872f6afe723d2b9654cbb0ecc43533d3c7d673c11fb96545d627f4bbacdbd351a1a61d0ee65d71381
    HEAD_REF master
)

vcpkg_from_github(
    OUT_SOURCE_PATH ROBDEF_SOURCE_PATH
    REPO robotraconteur/robotraconteur_companion
    REF v0.4.2
    SHA512 8bee3f71f6f1cedc6af9b30d32ed16515c2c117a4d43c3b6304c799fe90447056c5e447f573c96018c57112d9c174de422c16eba3a27b5c1343e88377d7e4117
    HEAD_REF master
)

file(COPY ${ROBDEF_SOURCE_PATH}/group1 DESTINATION ${SOURCE_PATH}/robdef/)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME RobotRaconteurCompanion
    CONFIG_PATH "lib/cmake/RobotRaconteurCompanion"
)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

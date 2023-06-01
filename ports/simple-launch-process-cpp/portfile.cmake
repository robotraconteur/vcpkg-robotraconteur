vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO johnwason/simple-launch-process-cpp
    REF eb36846b7867e27383a306f4b5242913be4d24ac
    SHA512 cb141b634e5026810ed4dc41a2728e4ed4c9a2def832fdb56048b70850c47d5160b54741ad80c6c9c259d705320198746fafef9124dfca022fc41157d0b1ea16
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT} )

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

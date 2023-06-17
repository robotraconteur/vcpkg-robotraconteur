vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO johnwason/drekar-launch-process-cpp
    REF ef0847b1b68eb872960cd2429dbb7d61b96a4977
    SHA512 3a0c7b591c8f4dac14d94114973afebba5b9ec6745aa9a7a264f628d6a9fbf41cb509dc881ff1b0c03b7a6d44cd422b329fbec8be59235db792c42aeb72476b4
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

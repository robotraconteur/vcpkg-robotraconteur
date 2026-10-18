vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO robotraconteur/robotraconteur
	REF v1.2.9
	SHA512 1e402089ccc8079feff9b98012aec5863862eb4edf089c765d862505d1f3b8b51ef5fc473c96e2df0e08bccae7531e962e8cb73ed4f231ecf53bb8898401d583
	HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
	OPTIONS
	    -DBUILD_GEN=ON
	    -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

vcpkg_copy_tools(TOOL_NAMES RobotRaconteurGen AUTO_CLEAN)

vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/robotraconteur)

vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/RobotRaconteur")

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

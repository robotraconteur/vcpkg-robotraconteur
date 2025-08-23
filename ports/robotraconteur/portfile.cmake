vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO robotraconteur/robotraconteur
	REF v1.2.6-rc2
	SHA512 7a928760413a74418ae9867b441da0e817e797a25d2f9b88668b3a61a965880160559c2f0f7a03572f80b41706f9128fb0a36f6e818cef4bc299b9ec6baeb3bc
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

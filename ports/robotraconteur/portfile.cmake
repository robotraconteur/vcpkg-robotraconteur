vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO robotraconteur/robotraconteur
	REF v1.2.2
	SHA512 e338e36ad6612e6d3bf3ed97661592a54f7bfc3d41c025f97af020095971fcf4af55f76350c5b3e81bb5880cda48515dae2bc3c1ebd587c4a33a87d087be6f25
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

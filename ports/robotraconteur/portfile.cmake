include(vcpkg_common_functions)

if(MSVC)
set(VCPKG_CXX_FLAGS_DEBUG "${VCPKG_CXX_FLAGS_DEBUG} /bigobj")
set(VCPKG_C_FLAGS_DEBUG "${VCPKG_C_FLAGS_DEBUG} /bigobj")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO robotraconteur/robotraconteur
	REF v0.15.0
	SHA512 05bc72c78e16b451439d86ecf3bc30806608cad0d55440c7424c6bebc1769d06df8e2dbe92ebdc33df9c4d9369c90789d7b06a182d8ed638577eef8ebcd1330f
	HEAD_REF master
	PATCHES
	  static-build.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
	OPTIONS
	    -DBUILD_GEN=ON
		-DBUILD_SHARED_LIBS=OFF
)

vcpkg_install_cmake()

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/robotraconteur")

if(CMAKE_HOST_WIN32)
file(INSTALL ${CURRENT_PACKAGES_DIR}/bin/RobotRaconteurGen.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/robotraconteur)
else()
file(INSTALL ${CURRENT_PACKAGES_DIR}/bin/RobotRaconteurGen DESTINATION ${CURRENT_PACKAGES_DIR}/tools/robotraconteur)
endif()
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/robotraconteur)

vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/RobotRaconteur")

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(COPY ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/robotraconteur/copyright)

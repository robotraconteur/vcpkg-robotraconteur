include(vcpkg_common_functions)

if(MSVC)
set(VCPKG_CXX_FLAGS_DEBUG "${VCPKG_CXX_FLAGS_DEBUG} /bigobj")
set(VCPKG_C_FLAGS_DEBUG "${VCPKG_C_FLAGS_DEBUG} /bigobj")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO robotraconteur/robotraconteur
	REF v0.13.0
	SHA512 c98d9cf95b6b616321758caa960c3d8490b0d8fc40e544d632598ffbeb07707661c9401f3df22b0dcc8205b68ef615b2b2ad22d273769b97f51c34b88e100041
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

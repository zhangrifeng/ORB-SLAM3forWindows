# This file will be configured to contain variables for CPack. These variables
# should be set in the CMake list file of the project before CPack module is
# included. The list of available CPACK_xxx variables and their associated
# documentation may be obtained using
#  cpack --help-variable-list
#
# Some variables are common to all generators (e.g. CPACK_PACKAGE_NAME)
# and some are specific to a generator
# (e.g. CPACK_NSIS_EXTRA_INSTALL_COMMANDS). The generator specific variables
# usually begin with CPACK_<GENNAME>_xxxx.


set(CPACK_BUILD_SOURCE_DIRS "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin;E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2")
set(CPACK_CMAKE_GENERATOR "Visual Studio 17 2022")
set(CPACK_COMPONENTS_ALL "")
set(CPACK_COMPONENT_UNSPECIFIED_HIDDEN "TRUE")
set(CPACK_COMPONENT_UNSPECIFIED_REQUIRED "TRUE")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Steven Lovegrove")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_FILE "D:/cpp/cmake-3.31.3-windows-x86_64/share/cmake-3.31/Templates/CPack.GenericDescription.txt")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_SUMMARY "Pangolin built using CMake")
set(CPACK_GENERATOR "DEB")
set(CPACK_INNOSETUP_ARCHITECTURE "x64")
set(CPACK_INSTALL_CMAKE_PROJECTS "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2;Pangolin;ALL;/")
set(CPACK_INSTALL_PREFIX "C:/Program Files (x86)/Pangolin")
set(CPACK_MODULE_PATH "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/CMakeModules/")
set(CPACK_NSIS_DISPLAY_NAME "Pangolin 0.5.0")
set(CPACK_NSIS_INSTALLER_ICON_CODE "")
set(CPACK_NSIS_INSTALLER_MUI_ICON_CODE "")
set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES64")
set(CPACK_NSIS_PACKAGE_NAME "Pangolin 0.5.0")
set(CPACK_NSIS_UNINSTALL_NAME "Uninstall")
set(CPACK_OUTPUT_CONFIG_FILE "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/CPackConfig.cmake")
set(CPACK_PACKAGE_DEFAULT_LOCATION "/")
set(CPACK_PACKAGE_DESCRIPTION_FILE "D:/cpp/cmake-3.31.3-windows-x86_64/share/cmake-3.31/Templates/CPack.GenericDescription.txt")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Pangolin built using CMake")
set(CPACK_PACKAGE_FILE_NAME "Pangolin-0.5.0-win64")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "Pangolin 0.5.0")
set(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "Pangolin 0.5.0")
set(CPACK_PACKAGE_NAME "Pangolin")
set(CPACK_PACKAGE_RELOCATABLE "true")
set(CPACK_PACKAGE_VENDOR "Humanity")
set(CPACK_PACKAGE_VERSION "0.5.0")
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "5")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_RESOURCE_FILE_LICENSE "D:/cpp/cmake-3.31.3-windows-x86_64/share/cmake-3.31/Templates/CPack.GenericLicense.txt")
set(CPACK_RESOURCE_FILE_README "D:/cpp/cmake-3.31.3-windows-x86_64/share/cmake-3.31/Templates/CPack.GenericDescription.txt")
set(CPACK_RESOURCE_FILE_WELCOME "D:/cpp/cmake-3.31.3-windows-x86_64/share/cmake-3.31/Templates/CPack.GenericWelcome.txt")
set(CPACK_SET_DESTDIR "OFF")
set(CPACK_SOURCE_7Z "ON")
set(CPACK_SOURCE_GENERATOR "7Z;ZIP")
set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/CPackSourceConfig.cmake")
set(CPACK_SOURCE_ZIP "ON")
set(CPACK_SYSTEM_NAME "win64")
set(CPACK_THREADS "1")
set(CPACK_TOPLEVEL_TAG "win64")
set(CPACK_WIX_SIZEOF_VOID_P "8")

if(NOT CPACK_PROPERTIES_FILE)
  set(CPACK_PROPERTIES_FILE "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/CPackProperties.cmake")
endif()

if(EXISTS ${CPACK_PROPERTIES_FILE})
  include(${CPACK_PROPERTIES_FILE})
endif()

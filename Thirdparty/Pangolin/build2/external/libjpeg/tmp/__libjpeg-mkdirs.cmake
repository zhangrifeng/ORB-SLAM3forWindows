# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg/src/__libjpeg")
  file(MAKE_DIRECTORY "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg/src/__libjpeg")
endif()
file(MAKE_DIRECTORY
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg/src/__libjpeg-build"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg/tmp"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg/src/__libjpeg-stamp"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg/src"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg/src/__libjpeg-stamp"
)

set(configSubDirs Debug;Release;MinSizeRel;RelWithDebInfo)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg/src/__libjpeg-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg/src/__libjpeg-stamp${cfgdir}") # cfgdir has leading slash
endif()

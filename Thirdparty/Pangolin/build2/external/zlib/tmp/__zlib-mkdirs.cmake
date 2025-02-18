# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/src/__zlib")
  file(MAKE_DIRECTORY "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/src/__zlib")
endif()
file(MAKE_DIRECTORY
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/src/__zlib-build"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/tmp"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/src/__zlib-stamp"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/src"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/src/__zlib-stamp"
)

set(configSubDirs Debug;Release;MinSizeRel;RelWithDebInfo)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/src/__zlib-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/src/__zlib-stamp${cfgdir}") # cfgdir has leading slash
endif()

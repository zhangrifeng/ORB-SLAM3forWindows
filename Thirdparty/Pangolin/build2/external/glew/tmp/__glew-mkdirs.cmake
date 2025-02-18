# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/src/__glew")
  file(MAKE_DIRECTORY "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/src/__glew")
endif()
file(MAKE_DIRECTORY
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/src/__glew-build"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/tmp"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/src/__glew-stamp"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/src"
  "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/src/__glew-stamp"
)

set(configSubDirs Debug;Release;MinSizeRel;RelWithDebInfo)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/src/__glew-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/src/__glew-stamp${cfgdir}") # cfgdir has leading slash
endif()

# Compute paths
get_filename_component( PROJECT_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH )
SET( Pangolin_INCLUDE_DIRS "${PROJECT_CMAKE_DIR}/../../../include;E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/include;E:/cpp/ORB-SLAM3forWindows/Thirdparty/eigen" )
SET( Pangolin_INCLUDE_DIR  "${PROJECT_CMAKE_DIR}/../../../include;E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/include;E:/cpp/ORB-SLAM3forWindows/Thirdparty/eigen" )

# Library dependencies (contains definitions for IMPORTED targets)
if( NOT TARGET pangolin AND NOT Pangolin_BINARY_DIR )
  include( "${PROJECT_CMAKE_DIR}/PangolinTargets.cmake" )
  
  add_library(_glew STATIC IMPORTED)
  set_target_properties(_glew PROPERTIES
    IMPORTED_LOCATION_RELEASE E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/lib/glew.lib
    IMPORTED_LOCATION_DEBUG   E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/glew/lib/glewd.lib
  )
  add_library(_zlib STATIC IMPORTED)
  set_target_properties(_zlib PROPERTIES
    IMPORTED_LOCATION_RELEASE E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/lib/zlibstatic.lib
    IMPORTED_LOCATION_DEBUG   E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/zlib/lib/zlibstaticd.lib
  )
  add_library(_libpng STATIC IMPORTED)
  set_target_properties(_libpng PROPERTIES
    IMPORTED_LOCATION_RELEASE E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libpng/lib/libpng16_static.lib
    IMPORTED_LOCATION_DEBUG   E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libpng/lib/libpng16_staticd.lib
  )
  add_library(_libjpeg STATIC IMPORTED)
  set_target_properties(_libjpeg PROPERTIES
    IMPORTED_LOCATION E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/build2/external/libjpeg/lib/jpeg.lib
  )
endif()

SET( Pangolin_LIBRARIES    pangolin )
SET( Pangolin_LIBRARY      pangolin )
SET( Pangolin_CMAKEMODULES E:/cpp/ORB-SLAM3forWindows/Thirdparty/Pangolin/src/../CMakeModules )

# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(miniz_library VERSION 1.0.0 LANGUAGES C)

add_library(miniz_v2 SHARED
  "miniz-2.2.0/wrapper.c"
  "miniz-2.2.0/miniz.c"
)

set_target_properties(miniz_v2 PROPERTIES
  PUBLIC_HEADER "miniz-2.2.0/miniz.h"
  OUTPUT_NAME "miniz_v2"
)

if (WIN32)
set_target_properties(miniz_v2 PROPERTIES
  WINDOWS_EXPORT_ALL_SYMBOLS ON
)
endif (WIN32)

target_compile_definitions(miniz_v2 PUBLIC DART_SHARED_LIB)

add_library(miniz_v3 SHARED
  "miniz-3.0.2/wrapper.c"
  "miniz-3.0.2/miniz.c"
)

set_target_properties(miniz_v3 PROPERTIES
  PUBLIC_HEADER "miniz-3.0.2/miniz.h"
  OUTPUT_NAME "miniz_v3"
)

if (WIN32)
set_target_properties(miniz_v3 PROPERTIES
  WINDOWS_EXPORT_ALL_SYMBOLS ON
)
endif (WIN32)

target_compile_definitions(miniz_v3 PUBLIC DART_SHARED_LIB)

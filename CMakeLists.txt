cmake_minimum_required(VERSION 4.2)

project(GuildWarsMapBrowser
    DESCRIPTION "Guild Wars map, model and texture browser"
    LANGUAGES C CXX RC
)

if(NOT MSVC)
    message(FATAL_ERROR "GuildWarsMapBrowser requires the MSVC toolchain")
endif()
if(NOT CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(FATAL_ERROR "GuildWarsMapBrowser builds for x64 only")
endif()

set(CMAKE_CONFIGURATION_TYPES Debug Release)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
include(GwmbOptions)
include(GwmbExternal)
include(GwmbSources)

add_subdirectory(external)
add_subdirectory(src)

set_property(DIRECTORY PROPERTY VS_STARTUP_PROJECT GuildWarsMapBrowser)

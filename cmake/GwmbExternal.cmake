# Helpers for declaring vendored third-party libraries under external/.
#
# Every helper creates `ext_<name>` plus the alias `ext::<name>`, which is the
# name consumers link against. Include directories are exported as SYSTEM so
# warnings from vendored headers do not leak into first-party code.

include_guard(GLOBAL)
include(GwmbOptions)

# Resolves <dirs_var> against CMAKE_CURRENT_SOURCE_DIR, defaulting to it when
# empty. Imported targets reject relative include directories.
macro(_gwmb_resolve_include_dirs dirs_var)
    if(NOT ${dirs_var})
        set(${dirs_var} ${CMAKE_CURRENT_SOURCE_DIR})
    endif()
    set(_gwmb_abs_dirs "")
    foreach(_gwmb_dir IN LISTS ${dirs_var})
        cmake_path(ABSOLUTE_PATH _gwmb_dir BASE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}" NORMALIZE)
        list(APPEND _gwmb_abs_dirs "${_gwmb_dir}")
    endforeach()
    set(${dirs_var} ${_gwmb_abs_dirs})
endmacro()

# gwmb_external_library(<name>
#     SOURCES <files>...
#     [INCLUDE_DIRS <dirs>...]     default: CMAKE_CURRENT_SOURCE_DIR
#     [LINK <targets/libs>...]
#     [DEFINES <defines>...])      public compile definitions
#
# Static library built from vendored sources with warnings disabled.
function(gwmb_external_library name)
    cmake_parse_arguments(PARSE_ARGV 1 arg "" "" "SOURCES;INCLUDE_DIRS;LINK;DEFINES")
    if(NOT arg_SOURCES)
        message(FATAL_ERROR "gwmb_external_library(${name}): SOURCES is required")
    endif()
    _gwmb_resolve_include_dirs(arg_INCLUDE_DIRS)

    add_library(ext_${name} STATIC ${arg_SOURCES})
    add_library(ext::${name} ALIAS ext_${name})
    gwmb_target_defaults(ext_${name})
    target_compile_options(ext_${name} PRIVATE /W0)
    target_include_directories(ext_${name} SYSTEM PUBLIC ${arg_INCLUDE_DIRS})
    target_compile_definitions(ext_${name} PUBLIC ${arg_DEFINES})
    target_link_libraries(ext_${name} PUBLIC ${arg_LINK})
    set_target_properties(ext_${name} PROPERTIES FOLDER external)
endfunction()

# gwmb_external_headers(<name>
#     [INCLUDE_DIRS <dirs>...]     default: CMAKE_CURRENT_SOURCE_DIR
#     [LINK <targets/libs>...])
#
# Header-only library.
function(gwmb_external_headers name)
    cmake_parse_arguments(PARSE_ARGV 1 arg "" "" "INCLUDE_DIRS;LINK")
    _gwmb_resolve_include_dirs(arg_INCLUDE_DIRS)

    add_library(ext_${name} INTERFACE)
    add_library(ext::${name} ALIAS ext_${name})
    target_include_directories(ext_${name} SYSTEM INTERFACE ${arg_INCLUDE_DIRS})
    target_link_libraries(ext_${name} INTERFACE ${arg_LINK})
endfunction()

# gwmb_external_imported(<name>
#     LIB <path>
#     [INCLUDE_DIRS <dirs>...])    default: CMAKE_CURRENT_SOURCE_DIR
#
# Prebuilt static library checked into the repository.
function(gwmb_external_imported name)
    cmake_parse_arguments(PARSE_ARGV 1 arg "" "LIB" "INCLUDE_DIRS")
    if(NOT arg_LIB OR NOT EXISTS "${arg_LIB}")
        message(FATAL_ERROR "gwmb_external_imported(${name}): LIB '${arg_LIB}' not found")
    endif()
    _gwmb_resolve_include_dirs(arg_INCLUDE_DIRS)

    add_library(ext_${name} STATIC IMPORTED GLOBAL)
    add_library(ext::${name} ALIAS ext_${name})
    set_target_properties(ext_${name} PROPERTIES IMPORTED_LOCATION "${arg_LIB}")
    target_include_directories(ext_${name} SYSTEM INTERFACE ${arg_INCLUDE_DIRS})
endfunction()

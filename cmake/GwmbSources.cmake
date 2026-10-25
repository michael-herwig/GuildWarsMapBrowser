# Source discovery and IDE grouping.

include_guard(GLOBAL)

# gwmb_glob_sources(<out_var> <dir>)
#
# Collects C++ sources, headers and HLSL files below <dir>. The glob is
# re-evaluated at build time, so adding a file only needs a rebuild.
# HLSL files are listed for the IDE only: shaders are embedded as strings in
# the matching *Shader.h headers and compiled at runtime with D3DCompile.
function(gwmb_glob_sources out_var dir)
    file(GLOB_RECURSE sources CONFIGURE_DEPENDS
        "${dir}/*.cpp" "${dir}/*.h" "${dir}/*.hpp" "${dir}/*.hlsl"
    )
    foreach(file IN LISTS sources)
        if(file MATCHES "\\.hlsl$")
            set_source_files_properties(${file} PROPERTIES HEADER_FILE_ONLY ON)
        endif()
    endforeach()
    set(${out_var} ${sources} PARENT_SCOPE)
endfunction()

# gwmb_source_tree(<target> <root>)
#
# Mirrors the directory layout below <root> as IDE folders.
function(gwmb_source_tree target root)
    get_target_property(sources ${target} SOURCES)
    set(in_root "")
    foreach(file IN LISTS sources)
        cmake_path(ABSOLUTE_PATH file BASE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}" NORMALIZE)
        cmake_path(IS_PREFIX root "${file}" NORMALIZE is_inside)
        if(is_inside)
            list(APPEND in_root "${file}")
        endif()
    endforeach()
    source_group(TREE "${root}" FILES ${in_root})
endfunction()

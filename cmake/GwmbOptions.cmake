# Compiler and linker settings shared by every target in the project.

include_guard(GLOBAL)

# gwmb_target_defaults(<target>)
#
# Applies the project baseline: C++20, Unicode Win32 app defines, MSVC
# conformance and floating point flags, and release optimizations with PDBs.
function(gwmb_target_defaults target)
    get_target_property(type ${target} TYPE)
    if(type STREQUAL "INTERFACE_LIBRARY")
        message(FATAL_ERROR "gwmb_target_defaults: ${target} is an INTERFACE library")
    endif()

    target_compile_features(${target} PRIVATE cxx_std_20)
    set_target_properties(${target} PROPERTIES CXX_EXTENSIONS OFF)

    target_compile_definitions(${target} PRIVATE
        WIN32 _WINDOWS UNICODE _UNICODE
        $<IF:$<CONFIG:Debug>,_DEBUG,NDEBUG>
    )

    target_compile_options(${target} PRIVATE
        /permissive- /Zc:__cplusplus /fp:fast /MP
        $<$<CONFIG:Release>:/O2 /Oi /Gy /Oy- /Zi>
    )

    target_link_options(${target} PRIVATE
        $<$<CONFIG:Release>:/DEBUG /OPT:REF /OPT:ICF>
    )
endfunction()

# gwmb_target_warnings(<target>)
#
# Warning level for first-party code. Vendored code stays quiet (see
# GwmbExternal.cmake).
function(gwmb_target_warnings target)
    target_compile_options(${target} PRIVATE /W4)
endfunction()

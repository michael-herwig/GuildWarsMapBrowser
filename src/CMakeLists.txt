set(resources_dir "${PROJECT_SOURCE_DIR}/resources")

gwmb_glob_sources(app_sources "${CMAKE_CURRENT_SOURCE_DIR}")

add_executable(GuildWarsMapBrowser WIN32
    ${app_sources}
    ${resources_dir}/app.rc
    ${resources_dir}/app.manifest
)

gwmb_target_defaults(GuildWarsMapBrowser)
gwmb_target_warnings(GuildWarsMapBrowser)

target_include_directories(GuildWarsMapBrowser PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${resources_dir}
)
target_precompile_headers(GuildWarsMapBrowser PRIVATE pch.h)

# app.rc embeds bass.dll / bass_fx.dll by bare file name.
set_property(SOURCE ${resources_dir}/app.rc APPEND PROPERTY INCLUDE_DIRECTORIES "${GWMB_BASS_BIN_DIR}")

target_link_libraries(GuildWarsMapBrowser PRIVATE
    ext::imgui
    ext::imgui_club
    ext::imguifiledialog
    ext::directxtex
    ext::murmurhash3
    ext::peglib
    ext::json
    ext::rapidcsv
    ext::stb
    ext::tinytiff
    ext::bass
    d3d11 dxgi dxguid uuid
    comdlg32 advapi32 shell32 ole32 oleaut32
    DbgHelp gdi32 gdiplus
)

# TinyTIFF_x64.lib is built against the release CRT (/MT).
target_link_options(GuildWarsMapBrowser PRIVATE $<$<CONFIG:Debug>:/NODEFAULTLIB:LIBCMT>)

set_target_properties(GuildWarsMapBrowser PROPERTIES
    VS_DPI_AWARE PerMonitor
    VS_DEBUGGER_WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
)

gwmb_source_tree(GuildWarsMapBrowser "${CMAKE_CURRENT_SOURCE_DIR}")
source_group(resources FILES ${resources_dir}/app.rc ${resources_dir}/app.manifest)

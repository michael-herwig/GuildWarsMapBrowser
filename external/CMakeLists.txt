# Vendored third-party libraries. See README.md for versions, licenses and
# upstream sources.

gwmb_external_library(imgui
    SOURCES
        imgui/imgui.cpp
        imgui/imgui_demo.cpp
        imgui/imgui_draw.cpp
        imgui/imgui_tables.cpp
        imgui/imgui_widgets.cpp
        imgui/imgui_impl_dx11.cpp
        imgui/imgui_impl_win32.cpp
        imgui/misc/cpp/imgui_stdlib.cpp
        imgui/misc/debuggers/imgui.natvis
    INCLUDE_DIRS imgui
    LINK d3d11 d3dcompiler dxgi
)

gwmb_external_headers(imgui_club INCLUDE_DIRS imgui_club LINK ext::imgui)

gwmb_external_library(imguifiledialog
    SOURCES imguifiledialog/ImGuiFileDialog.cpp
    INCLUDE_DIRS imguifiledialog
    LINK ext::imgui
)

gwmb_external_library(directxtex
    SOURCES
        directxtex/BC.cpp
        directxtex/BC4BC5.cpp
        directxtex/BC6HBC7.cpp
        directxtex/DDSTextureLoader11.cpp
        directxtex/DirectXTexCompress.cpp
        directxtex/DirectXTexConvert.cpp
        directxtex/DirectXTexD3D11.cpp
        directxtex/DirectXTexDDS.cpp
        directxtex/DirectXTexImage.cpp
        directxtex/DirectXTexMipmaps.cpp
        directxtex/DirectXTexUtil.cpp
        directxtex/DirectXTexWIC.cpp
    INCLUDE_DIRS directxtex
    LINK d3d11 dxguid ole32 windowscodecs
)

gwmb_external_library(murmurhash3
    SOURCES murmurhash3/MurmurHash3.cpp
    INCLUDE_DIRS murmurhash3
)

gwmb_external_headers(peglib INCLUDE_DIRS peglib)
gwmb_external_headers(json INCLUDE_DIRS nlohmann_json/include)
gwmb_external_headers(rapidcsv INCLUDE_DIRS rapidcsv/include)
gwmb_external_headers(stb INCLUDE_DIRS stb/include)

gwmb_external_imported(tinytiff
    LIB ${CMAKE_CURRENT_SOURCE_DIR}/tinytiff/TinyTIFF_x64.lib
    INCLUDE_DIRS tinytiff
)

# BASS is loaded at runtime from DLLs embedded as resources (resources/app.rc),
# so only the headers are needed at compile time.
gwmb_external_headers(bass INCLUDE_DIRS bass/include)
set(GWMB_BASS_BIN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/bass/bin/x64" PARENT_SCOPE)

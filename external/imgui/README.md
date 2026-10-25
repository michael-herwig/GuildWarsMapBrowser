# Dear ImGui

| | |
|---|---|
| Version | 1.90.1 WIP |
| License | MIT — LICENSE.txt |
| Upstream | https://github.com/ocornut/imgui |

**Update:** Copy `imgui*.{h,cpp}`, `imstb_*.h`, `backends/imgui_impl_{dx11,win32}.*` and `misc/cpp`, `misc/debuggers` from the release tag. Keep `imconfig.h` if it carries local settings.

**Local changes:** Backends live next to the core files (upstream: `backends/`). Unused `misc/fonts`, `misc/freetype`, `misc/single_file` removed.

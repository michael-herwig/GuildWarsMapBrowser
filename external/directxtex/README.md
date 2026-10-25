# DirectXTex



| | |

|---|---|

| Version | `DIRECTX_TEX_VERSION` 198 |

| License | MIT — LICENSE |

| Upstream | https://github.com/microsoft/DirectXTex |



**Update:** Copy `DirectXTex/*.{h,inl,cpp}` (subset listed in `external/CMakeLists.txt`) and `DDSTextureLoader/DDSTextureLoader11.*` from the release tag.



**Local changes:** Subset of sources only (D3D11, WIC, BC codecs, DDS loader). Shaders/GPU compressor not included. Upstream form restored: the sources no longer include the application's `pch.h`.


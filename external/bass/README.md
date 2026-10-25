# BASS / BASS_FX

| | |
|---|---|
| Version | BASS 2.4, BASS_FX 2.4.12 |
| License | Proprietary — free for non-commercial use — bass.txt (section *Licence*) |
| Upstream | https://www.un4seen.com (BASS_FX: https://www.jobnik.org) |

**Update:** Download the Windows packages, copy `bass.h` / `bass_fx.h` to `include/` and the x64 `bass.dll` / `bass_fx.dll` to `bin/x64/`.

**Local changes:** No import libraries: the DLLs are embedded as resources (`resources/app.rc`), extracted at startup and loaded with `LoadLibraryW`/`GetProcAddress` (`src/app/Main.cpp`).

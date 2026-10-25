#pragma once
#include "app/GuiGlobalConstants.h"
#include "render/MapRenderer.h"
#include "app/StepTimer.h"

void draw_right_panel(MapRenderer* map_renderer, int& FPS_target, DX::StepTimer& timer, bool& msaa_changed, int& msaa_level_index, const std::vector<std::pair<int, int>>& msaa_levels);

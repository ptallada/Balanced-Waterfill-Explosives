--settings.lua
data:extend({
    {
        type = "string-setting",
        name = "balanced-waterfill-recipe-cost-setting",
        setting_type = "startup",
        default_value = "Water Only",
        allowed_values = {"Water Only", "Uses Barrels", "Consumes Barrels", "Uses Explosives"},
        order = "b"
    },
    {
        type = "string-setting",
        name = "balanced-waterfill-collision-setting",
        setting_type = "startup",
        default_value = "Walkable",
        allowed_values = {"Walkable", "Kills Players", "Impassible"},
        order = "a"
    },
    {
        type = "string-setting",
        name = "balanced-waterfill-texture-setting",
        setting_type = "startup",
        default_value = "Default",
        allowed_values = {"Legacy", "Default"},
        order = "c"
    },
    {
        type = "bool-setting",
        name = "balanced-waterfill-biterspeed-setting",
        setting_type = "startup",
        default_value = true,
        order = "d"
    }
})

local CargoshipsOnWaterfillSetting = {
    type = "bool-setting",
    name = "balanced-waterfill-allow-cargo-ships-on-waterfill-setting",
    setting_type = "startup",
    default_value = true,
    hidden = true,
    order = "f"
}

--Space Exploration compatability setting
local DryWaterfillSetting = {
    type = "bool-setting",
    name = "balanced-waterfill-restrict-placement-se-setting",
    setting_type = "startup",
    default_value = true,
    hidden = true,
    order = "e"
}
if mods["space-exploration"] then
    DryWaterfillSetting.hidden = false
end
if mods["cargo-ships"] then
    CargoshipsOnWaterfillSetting.hidden = false
end

data:extend({DryWaterfillSetting, CargoshipsOnWaterfillSetting})

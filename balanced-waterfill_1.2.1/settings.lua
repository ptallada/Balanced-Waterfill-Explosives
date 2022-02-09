--settings.lua
data:extend({
    {
        type = "string-setting",
        name = "balanced-waterfill-recipe-cost-setting",
        setting_type = "startup",
        default_value = "Normal",
        allowed_values = {"Water only", "Normal", "Expensive"}
    },
    {
        type = "string-setting",
        name = "balanced-waterfill-collision-setting",
        setting_type = "startup",
        default_value = "Walkable",
        allowed_values = {"Walkable", "Kills Players", "Impassible"}
    },
    {
        type = "bool-setting",
        name = "balanced-waterfill-landfill-fix-se-setting",
        setting_type = "startup",
        default_value = true,
        hidden = true
    }
})

--Space Exploration compatability setting
local DryWaterfillSetting = {
    type = "bool-setting",
    name = "balanced-waterfill-restrict-placement-se-setting",
    setting_type = "startup",
    default_value = true,
    hidden = true
}
if mods["space-exploration"] then
    DryWaterfillSetting.hidden = false
end
data:extend({DryWaterfillSetting})
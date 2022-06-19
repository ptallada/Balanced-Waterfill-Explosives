--settings.lua
data:extend({
    {
        type = "string-setting",
        name = "balanced-waterfill-recipe-cost-setting",
        setting_type = "startup",
        default_value = "Water Only",
        allowed_values = {"Water Only", "Uses Barrels", "Consumes Barrels"}
    },
    {
        type = "string-setting",
        name = "balanced-waterfill-collision-setting",
        setting_type = "startup",
        default_value = "Walkable",
        allowed_values = {"Walkable", "Kills Players", "Impassible"}
    },
    {
        type = "string-setting",
        name = "balanced-waterfill-texture-setting",
        setting_type = "startup",
        default_value = "Default",
        allowed_values = {"Legacy", "Default"}
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
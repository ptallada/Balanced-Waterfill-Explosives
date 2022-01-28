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
    }
})
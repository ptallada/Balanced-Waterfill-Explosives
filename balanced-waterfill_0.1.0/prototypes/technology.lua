--technology.lua
local waterfill_tech = {
    type = "technology",
    name = "balanced-waterfill-tech",
    icon = "__RitnWaterfill__/graphics/waterfill.png",
    icon_size = 128, icon_mipmaps = 5,
    prerequisites = {"fluid-handling"},

    unit = {
        count = 50,
        time = 30,
        ingredients = {
            {"automation-science-pack", 1},
			{"logistic-science-pack", 1},
        }
    },

    effects = {
        {type = "unlock-recipe", recipe = "balanced-waterfill-recipe"}
    }
}

data:extend{waterfill_tech}
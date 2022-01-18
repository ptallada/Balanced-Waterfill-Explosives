--technology.lua

--Set up technology based on settings
if settings.startup["balanced-waterfill-recipe-cost-setting"].value == "Water only" then
    data:extend{
        {
            type = "technology",
            name = "balanced-waterfill-tech",
            icon = "__balanced-waterfill__/graphics/waterfill.png",
            icon_size = 128, icon_mipmaps = 5,
            prerequisites = {"automation-2"},
    
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
    }
else
    data:extend{
        {
            type = "technology",
            name = "balanced-waterfill-tech",
            icon = "__balanced-waterfill__/graphics/waterfill.png",
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
    }
end

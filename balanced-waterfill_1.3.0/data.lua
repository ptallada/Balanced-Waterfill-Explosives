--data.lua
require("prototypes.waterfill")
require("prototypes.technology")


print("Started balanced waterfill loading")

Biters = {
    "behemoth-biter",
    "behemoth-spitter",
    "big-biter",
    "big-spitter",
    "medium-biter",
    "medium-spitter",
    "small-biter",
    "small-spitter",
}

--Make certain entities not stop placement of waterfill, even when it collides
data.raw.character["character"].protected_from_tile_building = false
for a, biter in pairs(Biters) do
    if data.raw.unit[biter] then
        data.raw.unit[biter].protected_from_tile_building = false
    else
        print("invalid biter name: " .. biter)
    end
end

table.insert(data.raw["explosion"]["water-splash"].flags, "placeable-off-grid")
data.raw["optimized-particle"]["deep-water-particle"].render_layer = "ground-tile"

-- 1.3.0 checklist

--TODO code cleanup
--DONE write changelog 

--DONE Spidertrons don't work for some reason walking on waterfill??
--DONE cargo ships - bridges I THINK
--DONE mod setting ordering 
--DONE Beautiful bridges compatability 
--DONE setting for cargo ships on shallow waterfill
--DONE Landfill placeable - SE integration..
--DONE Full rewrite of collision mask logic
--DONE Fix typo in settings

--1.3.1 Plan?
--TODO move collision mask stuff to new file? Perhaps?
--TODO Beautiful bridges boat collision?
--TODO something like landfill everywhere?
--TODO remove weird one water tile thingy
--TODO cut unessesary collision layers dynamically based on loaded mods 

--Thanks to curiosity, ashley_sky and calcwizard for the advice given while making this mod, and for answers to my sily questions.
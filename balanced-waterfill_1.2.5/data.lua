--data.lua
require("prototypes.waterfill")
require("prototypes.technology")


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
-- data.raw.unit["behemoth-biter"].protected_from_tile_building = false
-- data.raw.unit["behemoth-spitter"].protected_from_tile_building = false
-- data.raw.unit["big-biter"].protected_from_tile_building = false
-- data.raw.unit["big-spitter"].protected_from_tile_building = false
-- data.raw.unit["medium-biter"].protected_from_tile_building = false
-- data.raw.unit["medium-spitter"].protected_from_tile_building = false
-- data.raw.unit["small-biter"].protected_from_tile_building = false
-- data.raw.unit["small-spitter"].protected_from_tile_building = false


--TODO cargo ships - bridges
--DONE Landfill placeable - SE integration..
--DONE Fix typo in settings

--TODO something like landfill everywhere?
--TODO remove weird one water tile thingy


--Thanks to curiosity, ashley_sky and calcwizard for the advice given while making this mod, and for answers to my sily questions.

--Scrapped for now: Water lamps
--Scrapped for now: Beautiful bridges compatability
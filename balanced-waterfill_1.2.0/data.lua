--data.lua
require("prototypes.waterfill")
require("prototypes.technology")

--Make certain entities not stop placement of waterfill, even when it collides
data.raw.character["character"].protected_from_tile_building = false
data.raw.unit["behemoth-biter"].protected_from_tile_building = false
data.raw.unit["behemoth-spitter"].protected_from_tile_building = false
data.raw.unit["big-biter"].protected_from_tile_building = false
data.raw.unit["big-spitter"].protected_from_tile_building = false
data.raw.unit["medium-biter"].protected_from_tile_building = false
data.raw.unit["medium-spitter"].protected_from_tile_building = false
data.raw.unit["small-biter"].protected_from_tile_building = false
data.raw.unit["small-spitter"].protected_from_tile_building = false

--Thanks to curiosity, ashley_sky and calcwizard for the advice given while making this mod, and for answers to my sily questions.
--data.lua

require("prototypes.waterfill")
require("prototypes.technology")

--Ensure other tiles have transitions to shallow waterfill
--I don't know why modifying one tile magicallly makes all the other tiles work, not complaining
for i, transition in pairs(data.raw.tile["concrete"].transitions) do
    table.insert(transition.to_tiles, "shallow-waterfill")
    i = i + 1
end

--Make player create splashing effects while walking over shallow waterfill
data.raw.character["character"].synced_footstep_particle_triggers[1].tiles = {"shallow-waterfill"}

--Make character not stop placement of waterfill, even when it collides
data.raw.character["character"].protected_from_tile_building = false


--Thanks to @curiosity#3406 and calcwizard#7488 for the advice given while making this mod, and for answers to my sily questions.
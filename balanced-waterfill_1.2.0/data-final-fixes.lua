--SE compatability
local waterfill_name = "shallow-waterfill"
if settings.startup["balanced-waterfill-restrict-placement-se-setting"].value == false then
    waterfill_name = "shallow-fill"
end

data.raw.character["character"].synced_footstep_particle_triggers[1].tiles = {waterfill_name}
data.raw.tile[waterfill_name].layer = 3
data.raw.item["balanced-waterfill"].place_as_tile.result = waterfill_name

--Ensure other tiles have transitions to shallow waterfill
local water_types = {
    "water",
    "water-shallow",
    "deepwater",
    "water-mud",
    "water-green",
    "deepwater-green",
}
local contains_water = false
for a, tile in pairs(data.raw.tile) do
    if tile.transitions then
        for b, transition in pairs(tile.transitions) do
            if transition.to_tiles then
                contains_water = false
                for c, tile_transition in pairs(transition.to_tiles) do
                    for d, water_type in pairs(water_types) do
                        if tile_transition == water_type then
                            contains_water = true
                        end
                    end
                end

                if contains_water then
                    table.insert(data.raw.tile[a].transitions[b].to_tiles, waterfill_name)
                end
                contains_water = false
            end
        end
    end
end
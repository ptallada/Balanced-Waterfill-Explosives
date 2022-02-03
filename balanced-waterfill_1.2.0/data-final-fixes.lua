--Reset layer for alien biomes compatability
data.raw.tile["shallow-waterfill"].layer = 3

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
                    table.insert(data.raw.tile[a].transitions[b].to_tiles, "shallow-waterfill")
                end
                contains_water = false
            end
        end
    end
end
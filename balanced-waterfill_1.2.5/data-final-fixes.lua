--data-final-fixes.lua
local collision_mask_util = require("collision-mask-util")

--Collect list of character names 
local characternames = {"character"}
for k, char in pairs(data.raw.character) do
    table.insert(characternames, char.name)
end

--Apply particles to a character
local function addFootstepParticles(namelist, tile)
    for k, char in pairs(namelist) do
        if data.raw.character[char].synced_footstep_particle_triggers then
            table.insert(data.raw.character[char].synced_footstep_particle_triggers[1].tiles, tile)
        end
    end
end


--Water footstep particles for waterfill
--table.insert(data.raw.character[charactername].synced_footstep_particle_triggers[1].tiles, "shallow-waterfill")
addFootstepParticles(characternames, "shallow-waterfill")
--SE compatability
if mods["space-exploration"] then
    if settings.startup["balanced-waterfill-restrict-placement-se-setting"].value == false then
        data.raw.item["balanced-waterfill"].place_as_tile.result = "shallow-fill"
    end

    -- ///////////////// UNUSED ///////////////////
    --local reconstructed_collision_mask = {}       could be handy later
    --for i, mask in ipairs(data.raw.tile["shallow-fill"].collision_mask) do
    --    if not(mask == "resource-layer") then
    --        table.insert(reconstructed_collision_mask, mask)
    --    end
    --end
    --data.raw.tile["shallow-fill"].collision_mask = reconstructed_collision_mask
    --data.raw.tile["shallow-waterfill"].collision_mask = reconstructed_collision_mask


    -- Allows placing waterfill on landfill with space exploration
    data.raw.item["balanced-waterfill"].place_as_tile.condition = { "item-layer", "object-layer", "water-tile", "player-layer", "transport-belt-layer", "train-layer" }



    --Footstep particles for the additional tile that only exists if SE is enabled
    --table.insert(data.raw.character[charactername].synced_footstep_particle_triggers[1].tiles, "shallow-fill")
    addFootstepParticles(characternames, "shallow-fill")

    --Reset tile transition layers for alien biomes compatability
    data.raw.tile["shallow-fill"].layer = 7
    
end

if mods["alien-biomes"] then
    data.raw.tile["shallow-waterfill"].layer = 7
end


--Ensure other tiles have transitions to shallow waterfill
local water_types = {
    "water",
    "water-shallow",
    "deepwater",
    "water-mud",
    "water-green",
    "deepwater-green",
}
local contains_water
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
                    if mods["space-exploration"] then
                        table.insert(data.raw.tile[a].transitions[b].to_tiles, "shallow-waterfill")
                        table.insert(data.raw.tile[a].transitions[b].to_tiles, "shallow-fill")
                    else
                        table.insert(data.raw.tile[a].transitions[b].to_tiles, "shallow-waterfill")
                    end
                end
                contains_water = false
            end
        end
    end
end


if settings.startup["balanced-waterfill-biterspeed-setting"].value == true then
    for a, biter in pairs(Biters) do
        if data.raw.unit[biter] then
            data.raw.unit[biter].affected_by_tiles = true
        end
    end
end

-- Cargo ships collision mask.. stuff
if mods["cargo-ships"] then -- TODO bridge
    local cargo_ships_compatability_layer = collision_mask_util.get_first_unused_layer()
    data.raw["electric-pole"]["floating-electric-pole"].collision_mask = {"ground-tile", cargo_ships_compatability_layer}

    data.raw["curved-rail"]["curved-water-way"].collision_mask = {"ground-tile", cargo_ships_compatability_layer}
    data.raw["curved-rail"]["curved-water-way-placed"].collision_mask = {cargo_ships_compatability_layer}
    data.raw["straight-rail"]["straight-water-way"].collision_mask = {"ground-tile", cargo_ships_compatability_layer}
    data.raw["straight-rail"]["straight-water-way-placed"].collision_mask = {cargo_ships_compatability_layer}
    data.raw["straight-rail"]["invisible_rail"].collisionw_mask = {cargo_ships_compatability_layer} -- Uhh
    data.raw["straight-rail"]["bridge_crossing"].collision_mask = {cargo_ships_compatability_layer}

    data.raw["train-stop"]["port"].collision_mask = {cargo_ships_compatability_layer}

    data.raw["pump"]["ship_pump"].collision_mask = {cargo_ships_compatability_layer}

    data.raw["mining-drill"]["oil_rig"].collision_mask = {"train-layer", cargo_ships_compatability_layer, "object-layer"}

    data.raw["straight-rail"]["straight-rail"].collision_mask = {"item-layer", "object-layer", "rail-layer", "floor-layer", "water-tile", cargo_ships_compatability_layer}
    data.raw["curved-rail"]["curved-rail"].collision_mask = {"item-layer", "object-layer", "rail-layer", "floor-layer", "water-tile", cargo_ships_compatability_layer}
end

-- ///// UNUSED ////// Factorio engine limitations, can't get placeable on waterfill, as well as land, while still colliding with objects on land, at least not well or cleanly
--if mods["beautiful_bridge_railway"] then -- Ehhhhhhh....
--    data.raw["straight-rail"]["bbr-straight-rail-wood"].collision_mask = 
--    data.raw["curved-rail"]["bbr-curved-rail-wood"].collision_mask = 
--
--    data.raw["straight-rail"]["bbr-straight-rail-brick"].collision_mask =
--    data.raw["curved-rail"]["bbr-curved-rail-brick"].collision_mask = 
--    
--    data.raw["straight-rail"]["bbr-straight-rail-iron"].collision_mask = 
--    data.raw["curved-rail"]["bbr-curved-rail-iron"].collision_mask = 
--end
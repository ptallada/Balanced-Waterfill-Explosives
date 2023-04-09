--data-final-fixes.lua
local collision_mask_util = require("collision-mask-util")



local function set_waterfill_collision_mask(mask)
    if mods["space-exploration"] then
        data.raw.tile["shallow-fill"].collision_mask = mask
        data.raw.tile["shallow-waterfill"].collision_mask = mask
    else
        data.raw.tile["shallow-waterfill"].collision_mask = mask
    end
end

local function insert_collision_masks_by_prototype(prototype, exceptions, waterLayer)
    for i, v in pairs(data.raw[prototype]) do 
        local valid_entity = true
        if exceptions then
            for key, value in pairs(exceptions) do
                if value == v.name then
                    valid_entity = false
                    break
                end
            end
        end
        if valid_entity then
            local mask = collision_mask_util.get_mask(v)
            table.insert(mask, waterLayer)
            data.raw[prototype][v.name].collision_mask = mask
            --print(v.name)
        end
    end
end

local function insert_collision_masks_by_layer(layer, exceptions, waterLayer)
    for k, v in pairs(collision_mask_util.collect_prototypes_with_layer(layer)) do
        local valid_entity = true
        if exceptions then
            for key, value in pairs(exceptions) do
                if value == v.name then
                    valid_entity = false
                    break
                end
            end
        end
        if valid_entity then
            local mask = collision_mask_util.get_mask(v)
            table.insert(mask, waterLayer)
            data.raw[v.type][v.name].collision_mask = mask
            print(v.name)
        end
    end
end


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
addFootstepParticles(characternames, "shallow-waterfill")
--SE compatability
if mods["space-exploration"] then
    -- SE compatability (disgusting hack part 3)
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
    addFootstepParticles(characternames, "shallow-fill")

    --Reset tile transition layers for alien biomes compatability, just to make sure
    data.raw.tile["shallow-fill"].layer = 7
    
end

-- Random compatability patch
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
--if mods["cargo-ships"] then -- TODO bridge
    --local cargo_ships_compatability_layer = collision_mask_util.get_first_unused_layer()
    --data.raw["electric-pole"]["floating-electric-pole"].collision_mask = {"ground-tile", cargo_ships_compatability_layer}

    --data.raw["curved-rail"]["curved-water-way"].collision_mask = {"ground-tile", cargo_ships_compatability_layer}
    --data.raw["curved-rail"]["curved-water-way-placed"].collision_mask = {cargo_ships_compatability_layer}
    --data.raw["straight-rail"]["straight-water-way"].collision_mask = {"ground-tile", cargo_ships_compatability_layer}
    --data.raw["straight-rail"]["straight-water-way-placed"].collision_mask = {cargo_ships_compatability_layer}
    --data.raw["straight-rail"]["invisible_rail"].collision_mask = {cargo_ships_compatability_layer} -- Uhh
    --data.raw["straight-rail"]["bridge_crossing"].collision_mask = {cargo_ships_compatability_layer}

    --data.raw["train-stop"]["port"].collision_mask = {cargo_ships_compatability_layer}

    --data.raw["pump"]["ship_pump"].collision_mask = {cargo_ships_compatability_layer}

    --data.raw["mining-drill"]["oil_rig"].collision_mask = {"train-layer", cargo_ships_compatability_layer, "object-layer"}

    --data.raw["straight-rail"]["straight-rail"].collision_mask = {"item-layer", "object-layer", "rail-layer", "floor-layer", "water-tile", cargo_ships_compatability_layer}
    --data.raw["curved-rail"]["curved-rail"].collision_mask = {"item-layer", "object-layer", "rail-layer", "floor-layer", "water-tile", cargo_ships_compatability_layer}
--end


-- Exceptions for collision masking
local object_layer_exceptions_cargo_ship = {"curved-water-way", "curved-water-way-placed", "straight-water-way", "straight-water-way-placed", "invisible_rail", "bridge_crossing", "port", "bridge-west-clickable", "bridge-east-clickable", "bridge-north-clickable", "bridge-south-clickable", "bridge_base"}
local object_layer_exceptions = {"floating-electric-pole", "ship_pump", "bbr-straight-rail-wood", "bbr-curved-rail-wood", "bbr-straight-rail-brick", "bbr-curved-rail-brick", "bbr-straight-rail-iron", "bbr-curved-rail-iron", "spidertron-leg-1", "spidertron-leg-2", "spidertron-leg-3", "spidertron-leg-4", "spidertron-leg-5", "spidertron-leg-6", "spidertron-leg-7", "spidertron-leg-8"}



--TODO cut unessesary collision layers to save on space 

-- Collision mask logic
-- Should emulate {"water-tile", "item-layer", "object-layer", "resource-layer", "doodad-layer"}
local waterfill_collision_layer_resource = collision_mask_util.get_first_unused_layer() -- Emulates resource-layer
set_waterfill_collision_mask({waterfill_collision_layer_resource}) --Hack to make mask "in use"
local waterfill_collision_layer_player = collision_mask_util.get_first_unused_layer() -- Emulates player-layer
set_waterfill_collision_mask({waterfill_collision_layer_player, waterfill_collision_layer_resource}) --Hack to make mask "in use"
local waterfill_collision_layer_object = collision_mask_util.get_first_unused_layer() -- Emulates object-layer

-- clear previous waterfill collision mask
set_waterfill_collision_mask({}) 

insert_collision_masks_by_layer("resource-layer", nil, waterfill_collision_layer_resource) -- Only needed when certain mods are installed

if settings.startup["balanced-waterfill-allow-cargo-ships-on-waterfill-setting"].value == true then
    for i, val in pairs(object_layer_exceptions_cargo_ship) do
        table.insert(object_layer_exceptions, val)
    end
end

insert_collision_masks_by_layer("object-layer", object_layer_exceptions, waterfill_collision_layer_object) -- Also only needed when certain mods are installed




--Make player and waterfill collide, while not colliding with spidertrons & whatnot depending on settings
if settings.startup["balanced-waterfill-collision-setting"].value == "Kills Players" then
    insert_collision_masks_by_prototype("character", nil, waterfill_collision_layer_player) -- Adds waterfill collision to all characters
end
if settings.startup["balanced-waterfill-collision-setting"].value == "Impassible" then
    print("BEGIN FISHING")
    insert_collision_masks_by_layer("player-layer", nil, waterfill_collision_layer_player) -- Adds waterfill collision to players, biters, vehicles, and anything else that contains with player-layer
    print("Bro")
end

set_waterfill_collision_mask({waterfill_collision_layer_resource, waterfill_collision_layer_player, waterfill_collision_layer_object, "item-layer", "doodad-layer", "water-tile"})

-- Reverse effects of collision mask changes on some selection boxes
for k1, type in pairs({"locomotive", "cargo-wagon", "fluid-wagon", "artillery-wagon"}) do -- Space Exploration codebase to the rescue 
    for k2, prototype in pairs(data.raw[type]) do
        prototype.selection_priority = 51
    end
end



-- Warning for likely incompatible entities, does not fire with only base mod entities for debugging purposes only
for key, value in pairs(collision_mask_util.collect_prototypes_with_mask({"object-layer"})) do
    print("Warning, only object layer! Likely incompatability!")
    print(value.name)
    print(value.type) -- swap prints for logs
end



print("Finished balanced waterfill loading!")
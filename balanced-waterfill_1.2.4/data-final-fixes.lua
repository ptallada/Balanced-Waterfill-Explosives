--data-final-fixes.lua

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
--control.lua
--Messing around with custom footstep particles, unimplemented for the time being

local waterTiles = {
    "shallow-waterfill",
    "shallow-fill"
}


local function player_moved_function(event)
    local player = game.get_player(event.player_index)

    if player.vehicle == nil then
        game.print("AA")
        return 
    end
    
    local surface = game.get_surface(player.surface.name)
    local stoodTile = surface.get_tile(player.position.x, player.position.y)

    for a, tile in pairs(waterTiles) do
        --game.print("SANITY" .. a)
        --game.print(tile)
        if tile == stoodTile.name then
            surface.create_entity{name = "water-splash", position = {player.position.x, player.position.y}}
        end
    end
    
    
end


--script.on_event(defines.events.on_player_changed_position, player_moved_function)
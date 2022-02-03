--Register event handlers
script.on_event(defines.events.on_player_built_tile, limitWaterPlacement)
script.on_event(defines.events.on_robot_built_tile, limitWaterPlacement)

--Prevent water from being placed on planets where it shouldn't be allowed (Space Exploration compatability)
function limitWaterPlacement(event) 
    if game.surfaces[event.surface_index].map_gen_settings.water==0 then
        if event.tile == "shallow-waterfill" then
            return cancel_tile_placement(game.surfaces[event.surface_index], event.tile, event.tiles, event.player_index, {"space-exploration.construction-denied-no-water"}, event, "nuclear-ground")
        end
    end
end


--Coped from control.lua in Space exploration, I found no other way to integrate the same cancelation mechanic without just copying how space exploration does it :/.
function cancel_tile_placement(surface, tile, old_tiles, player_index, message, event, fallback_tile_name)
    -- put an item back in the inventory or drop to ground
    -- display flying text
    local player
    if player_index then
      player = game.players[player_index]
      if player.controller_type == defines.controllers.editor then
        -- tile placement could be allowed for testing but it will create errors further down the line so this should not be enabled.
        -- e.g:
          -- space platform on a spaceship surface will break cause errors.
          -- water and/or land in space will cause entity problems.
          -- space surfaces on planets will cause entity problems and maybe errors.
      end
    end
    local set_tiles = {}
    for i, old_tile_and_position in pairs(old_tiles) do
      local position = old_tile_and_position.position
      local old_tile = old_tile_and_position.old_tile
  
      -- return the item for the new tile
      if tile.items_to_place_this and tile.items_to_place_this[1] then
        local inserted = 0
        if player then
          inserted = player.insert{name = tile.items_to_place_this[1].name, count = 1}
        end
        if inserted == 0 and event and event.robot then
          local inventory = event.robot.get_inventory(defines.inventory.robot_cargo)
          inserted = inventory.insert{name = tile.items_to_place_this[1].name, count = 1}
        end
        if inserted == 0 then
          --[[surface.create_entity{
            name = "item-on-ground",
            position = old_tile_and_position.position,
            --["item-entity"] = {name = tile.items_to_place_this[1].name, count = 1}
            stack = {name = tile.items_to_place_this[1].name, count = 1}
          }]]
          surface.spill_item_stack(
            old_tile_and_position.position,
            {name = tile.items_to_place_this[1].name, count = 1},
            true, -- loot
            player and player.force or (event and event.robot and event.robot.force),
            false -- allow_belts
          )
        end
      end
      if i == 1 then
        surface.create_entity{
          name = "flying-text",
          position = old_tile_and_position.position,
          text = message,
          render_player_index = player_index,
       }
      end
  
      -- try to restore the previous state, reclaim the removed item
      local inventory
      if player then inventory = player.get_inventory(defines.inventory.character_main) end
      if event and event.robot then inventory = event.robot.get_inventory(defines.inventory.robot_cargo) end
  
      local handled = false
      if inventory then
        if old_tile.items_to_place_this and old_tile.items_to_place_this[1] then
          local item = old_tile.items_to_place_this[1]
          local removed = inventory.remove({name = item.name, count = 1})
          if removed > 0 then
            handled = true
            table.insert(set_tiles, {name = old_tile.name, position = old_tile_and_position.position})
          end
        end
      end
  
      -- The old tile has no item to place, so putting it back should be fine
      if not (old_tile.items_to_place_this and old_tile.items_to_place_this[1]) then
        handled = true
        table.insert(set_tiles, {name = old_tile.name, position = old_tile_and_position.position})
      end
  
      -- Try the hidden tile
      -- or a fallback tile
      if not handled then
        local hidden = surface.get_hidden_tile(old_tile_and_position.position) or (fallback_tile_name or "out-of-map")
        local hidden_tile = game.tile_prototypes[hidden]
        table.insert(set_tiles, {name = hidden, position = old_tile_and_position.position})
        -- if this change would make an entity invalid then the entity needs to be removed.
  
        local collision_mask = {}
        for name, blocks in pairs(hidden_tile.collision_mask) do
          if blocks then table.insert(collision_mask, name) end
        end
        local entities = surface.find_entities_filtered{
          area = util.tile_to_area(old_tile_and_position.position),
          collision_mask = collision_mask}
        for _, entity in pairs(entities) do
          if player then player.mine_entity(entity, true) end
          if entity.valid then
            cancel_entity_creation(entity, player_index, message, event)
          end
          if entity.valid then -- fallback
            entity.destroy()
          end
        end
      end
    end
    surface.set_tiles(set_tiles)
  end
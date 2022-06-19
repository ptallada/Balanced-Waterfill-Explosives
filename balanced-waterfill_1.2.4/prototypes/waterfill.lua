--waterfill.lua
local collision_mask_util = require("collision-mask-util")

--Default water tile
local shallowater = {
  name = "shallow-waterfill",
  collision_mask = {"water-tile", "item-layer", "object-layer", "resource-layer", "doodad-layer"},
  check_collision_with_entities = true,
  draw_in_water_layer = true,
  type = "tile",
  layer = 7,
  can_be_part_of_blueprint = true,
  transition_merges_with_tile = "water",
  effect = "water",
  effect_color = {
    10,
    40,
    54,
    48
  },
  effect_color_secondary = {
    a = 0.36099999999999999,
    b = 0.031000000000000001,
    g = 0.129,
    r = 0.031000000000000001
  },
  map_color = {
    b = 95,
    g = 83,
    r = 51
  },
  scorch_mark_color = {
    b = 92,
    g = 98,
    r = 82
  },
  pollution_absorption_per_second = 5e-06,
  
  transitions = {
    {
      apply_effect_color_to_overlay = true,
      background_layer_group = "zero",
      background_layer_offset = 1,
      effect_mask = {
        filename = "__base__/graphics/terrain/effects/water-edge-mask.png",
        frame_count = 47,
        line_length = 8,
        scale = 0.5,
        size = 64
      },
      inner_corner = {
        count = 4,
        hr_version = {
          count = 4,
          line_length = 4,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-out-of-map-transition-tintable.png",
          scale = 0.5,
          tall = true,
          x = 0,
          y = 0
        },
        line_length = 4,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-out-of-map-transition-tintable.png",
        tall = true,
        x = 0,
        y = 0
      },
      o_transition = {
        count = 1,
        hr_version = {
          count = 1,
          line_length = 1,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-out-of-map-transition-tintable.png",
          scale = 0.5,
          tall = false,
          x = 0,
          y = 2304
        },
        line_length = 1,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-out-of-map-transition-tintable.png",
        tall = false,
        x = 0,
        y = 1152
      },
      offset_background_layer_by_tile_layer = true,
      outer_corner = {
        count = 4,
        hr_version = {
          count = 4,
          line_length = 4,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-out-of-map-transition-tintable.png",
          scale = 0.5,
          tall = true,
          x = 0,
          y = 576
        },
        line_length = 4,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-out-of-map-transition-tintable.png",
        tall = true,
        x = 0,
        y = 288
      },
      overlay_layer_group = "zero",
      side = {
        count = 8,
        hr_version = {
          count = 8,
          line_length = 8,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-out-of-map-transition-tintable.png",
          scale = 0.5,
          tall = true,
          x = 0,
          y = 1152
        },
        line_length = 8,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-out-of-map-transition-tintable.png",
        tall = true,
        x = 0,
        y = 576
      },
      to_tiles = {
        "out-of-map"
      },
      transition_group = 2,
      u_transition = {
        count = 1,
        hr_version = {
          count = 1,
          line_length = 1,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-out-of-map-transition-tintable.png",
          scale = 0.5,
          tall = true,
          x = 0,
          y = 1728
        },
        line_length = 1,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-out-of-map-transition-tintable.png",
        tall = true,
        x = 0,
        y = 864
      }
    }
  },

  trigger_effect = {
    {
      affects_target = false,
      frame_speed = 1,
      frame_speed_deviation = 0,
      initial_height = 0.1,
      initial_height_deviation = 0.5,
      initial_vertical_speed = 0.125,
      initial_vertical_speed_deviation = 0.069000000000000004,
      offset_deviation = {
        {
          -0.29689999999999998,
          -0.29689999999999998
        },
        {
          0.29689999999999998,
          0.29689999999999998
        }
      },
      offsets = {
        {
          0,
          0
        }
      },
      particle_name = "shallow-water-particle",
      probability = 1,
      repeat_count = 10,
      repeat_count_deviation = 4,
      show_in_tooltip = false,
      speed_from_center = 0.05,
      speed_from_center_deviation = 0.05,
      tail_length = 12,
      tail_length_deviation = 20,
      tail_width = 1,
      type = "create-particle"
    },
    {
      affects_target = false,
      frame_speed = 1,
      frame_speed_deviation = 0,
      initial_height = 0.1,
      initial_height_deviation = 0.5,
      initial_vertical_speed = 0.125,
      initial_vertical_speed_deviation = 0.069000000000000004,
      offset_deviation = {
        {
          -0.29689999999999998,
          -0.29689999999999998
        },
        {
          0.29689999999999998,
          0.29689999999999998
        }
      },
      offsets = {
        {
          0,
          0
        }
      },
      particle_name = "shallow-water-lower-particle",
      probability = 1,
      repeat_count = 7,
      repeat_count_deviation = 4,
      show_in_tooltip = false,
      speed_from_center = 0.05,
      speed_from_center_deviation = 0.05,
      tail_length = 12,
      tail_length_deviation = 20,
      tail_width = 1,
      type = "create-particle"
    }
  },

  transitions_between_transitions = {
    {
      background_layer_group = "zero",
      background_layer_offset = 1,
      inner_corner_background = {
        count = 3,
        hr_version = {
          count = 3,
          line_length = 3,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-shallow-out-of-map-transition-to-water.png",
          scale = 0.5,
          tall = true,
          x = 1088,
          y = 0
        },
        line_length = 3,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-shallow-out-of-map-transition-to-water.png",
        tall = true,
        x = 544,
        y = 0
      },
      inner_corner_mask = {
        count = 3,
        hr_version = {
          count = 3,
          line_length = 3,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-shallow-out-of-map-transition-to-water.png",
          scale = 0.5,
          x = 2176,
          y = 0
        },
        line_length = 3,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-shallow-out-of-map-transition-to-water.png",
        x = 1088,
        y = 0
      },
      offset_background_layer_by_tile_layer = true,
      outer_corner_background = {
        count = 3,
        hr_version = {
          count = 3,
          line_length = 3,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-shallow-out-of-map-transition-to-water.png",
          scale = 0.5,
          tall = true,
          x = 1088,
          y = 576
        },
        line_length = 3,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-shallow-out-of-map-transition-to-water.png",
        tall = true,
        x = 544,
        y = 288
      },
      outer_corner_mask = {
        count = 3,
        hr_version = {
          count = 3,
          line_length = 3,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-shallow-out-of-map-transition-to-water.png",
          scale = 0.5,
          x = 2176,
          y = 576
        },
        line_length = 3,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-shallow-out-of-map-transition-to-water.png",
        x = 1088,
        y = 288
      },
      side_background = {
        count = 3,
        hr_version = {
          count = 3,
          line_length = 3,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-shallow-out-of-map-transition-to-water.png",
          scale = 0.5,
          tall = true,
          x = 1088,
          y = 1152
        },
        line_length = 3,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-shallow-out-of-map-transition-to-water.png",
        tall = true,
        x = 544,
        y = 576
      },
      side_mask = {
        count = 3,
        hr_version = {
          count = 3,
          line_length = 3,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-shallow-out-of-map-transition-to-water.png",
          scale = 0.5,
          x = 2176,
          y = 1152
        },
        line_length = 3,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-shallow-out-of-map-transition-to-water.png",
        x = 1088,
        y = 576
      },
      transition_group = 0,
      transition_group1 = 0,
      transition_group2 = 2,
      u_transition_background = {
        count = 1,
        hr_version = {
          count = 1,
          line_length = 1,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-shallow-out-of-map-transition-to-water.png",
          scale = 0.5,
          tall = true,
          x = 1088,
          y = 1728
        },
        line_length = 1,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-shallow-out-of-map-transition-to-water.png",
        tall = true,
        x = 544,
        y = 864
      },
      u_transition_mask = {
        count = 1,
        hr_version = {
          count = 1,
          line_length = 1,
          picture = "__base__/graphics/terrain/out-of-map-transition/hr-water-shallow-out-of-map-transition-to-water.png",
          scale = 0.5,
          x = 2176,
          y = 1728
        },
        line_length = 1,
        picture = "__base__/graphics/terrain/out-of-map-transition/water-shallow-out-of-map-transition-to-water.png",
        x = 1088,
        y = 864
      }
    }
  },
  variants = {
    inner_corner = {
      count = 6,
      hr_version = {
        count = 6,
        picture = "__base__/graphics/terrain/water-shallow/hr-water-shallow-inner-corner.png",
        scale = 0.5
      },
      picture = "__base__/graphics/terrain/water-shallow/water-shallow-inner-corner.png"
    },
    main = {
      {
        count = 8,
        hr_version = {
          count = 8,
          picture = "__base__/graphics/terrain/water-shallow/hr-water-shallow2.png",
          scale = 0.5,
          size = 1
        },
        picture = "__base__/graphics/terrain/water-shallow/water-shallow2.png",
        size = 1
      },
      {
        count = 8,
        hr_version = {
          count = 8,
          picture = "__base__/graphics/terrain/water-shallow/hr-water-shallow2.png",
          scale = 0.5,
          size = 2
        },
        picture = "__base__/graphics/terrain/water-shallow/water-shallow2.png",
        size = 2
      },
      {
        count = 8,
        hr_version = {
          count = 8,
          picture = "__base__/graphics/terrain/water-shallow/hr-water-shallow4.png",
          scale = 0.5,
          size = 4
        },
        picture = "__base__/graphics/terrain/water-shallow/water-shallow4.png",
        size = 4
      }
    },
    o_transition = {
      count = 1,
      hr_version = {
        count = 1,
        picture = "__base__/graphics/terrain/water-shallow/hr-water-shallow-o.png",
        scale = 0.5
      },
      picture = "__base__/graphics/terrain/water-shallow/water-shallow-o.png"
    },
    outer_corner = {
      count = 6,
      hr_version = {
        count = 6,
        picture = "__base__/graphics/terrain/water-shallow/hr-water-shallow-outer-corner.png",
        scale = 0.5
      },
      picture = "__base__/graphics/terrain/water-shallow/water-shallow-outer-corner.png"
    },
    side = {
      count = 6,
      hr_version = {
        count = 6,
        picture = "__base__/graphics/terrain/water-shallow/hr-water-shallow-side.png",
        scale = 0.5
      },
      picture = "__base__/graphics/terrain/water-shallow/water-shallow-side.png"
    },
    u_transition = {
      count = 1,
      hr_version = {
        count = 1,
        picture = "__base__/graphics/terrain/water-shallow/hr-water-shallow-u.png",
        scale = 0.5
      },
      picture = "__base__/graphics/terrain/water-shallow/water-shallow-u.png"
    }
  },
  walking_speed_modifier = 0.5,
  vehicle_friction_modifier = 20,

  walking_sound = {
    {
      filename = "__base__/sound/walking/shallow-water-01.ogg",
      volume = 1
    },
    {
      filename = "__base__/sound/walking/shallow-water-02.ogg",
      volume = 1
    },
    {
      filename = "__base__/sound/walking/shallow-water-03.ogg",
      volume = 1
    },
    {
      filename = "__base__/sound/walking/shallow-water-04.ogg",
      volume = 1
    },
    {
      filename = "__base__/sound/walking/shallow-water-05.ogg",
      volume = 1
    },
    {
      filename = "__base__/sound/walking/shallow-water-06.ogg",
      volume = 1
    },
    {
      filename = "__base__/sound/walking/shallow-water-07.ogg",
      volume = 1
    }
  },
}

if settings.startup["balanced-waterfill-texture-setting"].value == "Default" then
  shallowater.variants = {
    inner_corner = {
      count = 6,
      hr_version = {
        count = 6,
        picture = "__base__/graphics/terrain/water-mud/hr-water-mud-inner-corner.png",
        scale = 0.5
      },
      picture = "__base__/graphics/terrain/water-mud/water-mud-inner-corner.png"
    },
    main = {
      {
        count = 8,
        hr_version = {
          count = 8,
          picture = "__base__/graphics/terrain/water-mud/hr-water-mud1.png",
          scale = 0.5,
          size = 1
        },
        picture = "__base__/graphics/terrain/water-mud/water-mud1.png",
        size = 1
      },
      {
        count = 8,
        hr_version = {
          count = 8,
          picture = "__base__/graphics/terrain/water-mud/hr-water-mud2.png",
          scale = 0.5,
          size = 2
        },
        picture = "__base__/graphics/terrain/water-mud/water-mud2.png",
        size = 2
      },
      {
        count = 8,
        hr_version = {
          count = 8,
          picture = "__base__/graphics/terrain/water-mud/hr-water-mud4.png",
          scale = 0.5,
          size = 4
        },
        picture = "__base__/graphics/terrain/water-mud/water-mud4.png",
        size = 4
      }
    },
    o_transition = {
      count = 1,
      hr_version = {
        count = 1,
        picture = "__base__/graphics/terrain/water-mud/hr-water-mud-o.png",
        scale = 0.5
      },
      picture = "__base__/graphics/terrain/water-mud/water-mud-o.png"
    },
    outer_corner = {
      count = 6,
      hr_version = {
        count = 6,
        picture = "__base__/graphics/terrain/water-mud/hr-water-mud-outer-corner.png",
        scale = 0.5
      },
      picture = "__base__/graphics/terrain/water-mud/water-mud-outer-corner.png"
    },
    side = {
      count = 6,
      hr_version = {
        count = 6,
        picture = "__base__/graphics/terrain/water-mud/hr-water-mud-side.png",
        scale = 0.5
      },
      picture = "__base__/graphics/terrain/water-mud/water-mud-side.png"
    },
    u_transition = {
      count = 1,
      hr_version = {
        count = 1,
        picture = "__base__/graphics/terrain/water-mud/hr-water-mud-u.png",
        scale = 0.5
      },
      picture = "__base__/graphics/terrain/water-mud/water-mud-u.png"
    }
  }
end
--Default waterfill placing item
local waterfill = {
    type = "item",
    name = "balanced-waterfill",
    tooltip = "placeholder",
    icon = "__balanced-waterfill__/graphics/waterfill.png",
    icon_size = 128, icon_mipmaps = 4,
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]",
    stack_size = 200,
    place_as_tile =
    {
      result = "shallow-waterfill",
      condition_size = 1,
      condition = { "item-layer", "object-layer", "water-tile", "resource-layer","player-layer", "transport-belt-layer", "train-layer"}
    }
}

--Default Recipe
local recipe = {
  type = "recipe",
  name = "balanced-waterfill-recipe",
  icon = "__balanced-waterfill__/graphics/waterfill.png",
  icon_size = 128, icon_mipmaps = 4,
  energy_required = 1,
  enabled = false,
  subgroup = "terrain",
  category = "advanced-crafting",
  ingredients = {{"water-barrel",5}},
  results = {
    {type="item", name="balanced-waterfill", amount=1},
    {type="item", name="empty-barrel", amount=5}
  },
  order = "c[landfill]-a[dirt]",
  result_count = 1
}

--Set up recipe based off of settings
if settings.startup["balanced-waterfill-recipe-cost-setting"].value == "Water Only" then
  recipe.category = "crafting-with-fluid"
  recipe.ingredients = {{type="fluid", name="water", amount=250}}
  recipe.results = {
    {type="item", name="balanced-waterfill", amount=1}
}
elseif settings.startup["balanced-waterfill-recipe-cost-setting"].value == "Uses Barrels" then
  recipe.category = "advanced-crafting"
  recipe.ingredients = {{"water-barrel",5}}
  recipe.results = {
    {type="item", name="balanced-waterfill", amount=1},
    {type="item", name="empty-barrel", amount=5}
}
elseif settings.startup["balanced-waterfill-recipe-cost-setting"].value == "Consumes Barrels" then
  recipe.category = "advanced-crafting"
  recipe.ingredients = {{"water-barrel",5}}
  recipe.results = {
    {type="item", name="balanced-waterfill", amount=1},
} end

--Make player and waterfill collide, while not colliding with spidertrons & whatnot
if settings.startup["balanced-waterfill-collision-setting"].value == "Kills Players" then
  local additional_player_layer = collision_mask_util.get_first_unused_layer()
  shallowater.collision_mask = {"water-tile", "item-layer", "object-layer", "resource-layer", "doodad-layer", additional_player_layer}
  data.raw["character"]["character"].collision_mask = {"player-layer", "train-layer", "consider-tile-transitions", additional_player_layer}
end
if settings.startup["balanced-waterfill-collision-setting"].value == "Impassible" then
  shallowater.collision_mask = {"water-tile", "item-layer", "object-layer", "resource-layer", "doodad-layer", "player-layer"}
end

--SE compatability (disgusting hack)
if mods["space-exploration"] then
  if settings.startup["balanced-waterfill-restrict-placement-se-setting"].value == false then
    shallowater.name = "shallow-fill"
  end
end

--Add everything to data.raw
data:extend{waterfill, recipe, shallowater}

--SE compatability (disgusting hack part 2)
if mods["space-exploration"] then
  local shallowater_compatability_replacement
  if settings.startup["balanced-waterfill-restrict-placement-se-setting"].value == false then
    shallowater_compatability_replacement = table.deepcopy(data.raw.tile["shallow-fill"])
    shallowater_compatability_replacement.name = "shallow-waterfill"
  else
    shallowater_compatability_replacement = table.deepcopy(data.raw.tile["shallow-waterfill"])
    shallowater_compatability_replacement.name = "shallow-fill"
  end
  data:extend{shallowater_compatability_replacement}
end
dcircuits.on_place_connect = function(pos, player, itemstack, pointed_thing)
  local p
  local n
  local i = 0
  while i < 4 do
    p = vector.add(pos, minetest.facedir_to_dir(i))
    n = minetest.get_node(p)
    if n.name == "dcircuits:dcircuits_con_0" then
      break
    end
    i = i + 1
  end
  if i < 4 then
    local back = (i + 6 - n.param2) % 4
    if back > 0 then 
      local node = minetest.get_node(pos)
      node.param2 = i
      minetest.swap_node(pos, node)
      n.name = "dcircuits:dcircuits_con_"..tostring(back)
      minetest.swap_node(p, n)
    end
  end
end

local function register_wire(i)
  if dcircuits.config.replace_connections == "specialize" then 
    minetest.register_node("dcircuits:dcircuits_con_"..i,{
      description = "Wire",
      inventory_image = "dcircuits_con_"..i..".png",
      tiles = {"dcircuits_con_"..i..".png"},
      drawtype = "nodebox",
      node_box = {
        type = "fixed",
        fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
      },
      paramtype = "light",
      paramtype2 = "facedir",
      walkable = true,
      groups = {snappy = 1, oddly_breakable_by_hand = 1},   -- wire
      after_place_node = dcircuits.on_place_connect,
    })
    if tonumber(i) > 0 then
      minetest.register_node("dcircuits:dcircuits_con_"..i.."_boolean",{
        description = "Wire",
        tiles = {"dcircuits_con_"..i.."_bool.png"},
        drawtype = "nodebox",
        node_box = {
          type = "fixed",
          fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
        },
        paramtype = "light",
        paramtype2 = "facedir",
        walkable = true,
        groups = {not_in_creative_inventory = 1, snappy = 1, oddly_breakable_by_hand = 1},   -- wire
        after_dig_node = dcircuits.after_dig_connection,
        drop = "dcircuits:dcircuits_con_"..i,
      })
      minetest.register_node("dcircuits:dcircuits_con_"..i.."_integer",{
        description = "Wire",
        tiles = {"dcircuits_con_"..i.."_int.png"},
        drawtype = "nodebox",
        node_box = {
          type = "fixed",
          fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
        },
        paramtype = "light",
        paramtype2 = "facedir",
        walkable = true,
        groups = {not_in_creative_inventory = 1, snappy = 1, oddly_breakable_by_hand = 1},   -- wire
        after_dig_node = dcircuits.after_dig_connection,
        drop = "dcircuits:dcircuits_con_"..i,
      })
      minetest.register_node("dcircuits:dcircuits_con_"..i.."_string",{
        description = "Wire",
        tiles = {"dcircuits_con_"..i.."_str.png"},
        drawtype = "nodebox",
        node_box = {
          type = "fixed",
          fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
        },
        paramtype = "light",
        paramtype2 = "facedir",
        walkable = true,
        groups = {not_in_creative_inventory = 1, snappy = 1, oddly_breakable_by_hand = 1},   -- wire
        after_dig_node = dcircuits.after_dig_connection,
        drop = "dcircuits:dcircuits_con_"..i,
      })
    end
  elseif dcircuits.config.replace_connections == "dissolve" then
    minetest.register_node("dcircuits:dcircuits_con_"..i,{
      description = "Wire",
      inventory_image = "dcircuits_con_"..i..".png",
      tiles = {"dcircuits_con_"..i..".png"},
      drawtype = "nodebox",
      node_box = {
        type = "fixed",
        fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
      },
      paramtype = "light",
      paramtype2 = "facedir",
      walkable = true,
      groups = {snappy = 1, oddly_breakable_by_hand = 1},   -- wire
      after_place_node = dcircuits.on_place_connect,
    })
  else
    minetest.register_node("dcircuits:dcircuits_con_"..i,{
      description = "Wire",
      inventory_image = "dcircuits_con_"..i..".png",
      tiles = {"dcircuits_con_"..i..".png"},
      drawtype = "nodebox",
      node_box = {
        type = "fixed",
        fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
      },
      paramtype = "light",
      paramtype2 = "facedir",
      walkable = true,
      groups = {snappy = 1, oddly_breakable_by_hand = 1},   -- wire
      after_place_node = dcircuits.on_place_connect,
      after_dig_node = dcircuits.after_dig_connection,
    })
  end
end

register_wire("0")
register_wire("1")
register_wire("2")
register_wire("3")


minetest.register_node("dcircuits:dcircuits_conIcross_x",{
  description = "Wire",
  inventory_image = "dcircuits_con_x.png",
  tiles = {"dcircuits_con_x.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},   -- wire
  after_dig_node = dcircuits.after_dig_connection,
})

minetest.register_node("dcircuits:dcircuits_conItop_i_to_below",{
  description = "Wire to below",
  inventory_image = "dcircuits_con_in.png",
  tiles = {"dcircuits_con_in.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},   -- wire
  after_dig_node = dcircuits.after_dig_connection,
})

minetest.register_node("dcircuits:dcircuits_conItop_o_from_below",{
  description = "Wire from below",
  inventory_image = "dcircuits_con_out.png",
  tiles = {"dcircuits_con_out.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},   -- wire
  after_dig_node = dcircuits.after_dig_connection,
})

minetest.register_node("dcircuits:dcircuits_conIarw_d_down",{
  description = "Wire down",
  inventory_image = "dcircuits_con_down.png",
  tiles = { "dcircuits_con_empty.png", "dcircuits_con_empty.png",
            "dcircuits_con_down.png", "dcircuits_con_down.png",
            "dcircuits_con_down.png", "dcircuits_con_down.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { {-0.5,    -0.5,     -0.5,     0.5,    -0.4375 , 0.5},
              {-0.0625, -0.4375,  -0.0625,  0.0625, 0,        0.0625},
              {-0.1875, 0,        -0.1875,  0.1875, 0.25,     0.1875},
              {-0.3125, 0.25,     -0.3125,  0.3125, 0.5,      0.3125},}
  },
  paramtype = "light",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},   -- wire
  after_dig_node = dcircuits.after_dig_connection,
})

minetest.register_node("dcircuits:dcircuits_conIarw_u_up",{
  description = "Wire up",
  inventory_image = "dcircuits_con_up.png",
  tiles = { "dcircuits_con_empty.png", "dcircuits_con_empty.png",
            "dcircuits_con_up.png", "dcircuits_con_up.png",
            "dcircuits_con_up.png", "dcircuits_con_up.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { {-0.5,    -0.5,     -0.5,     0.5,    -0.4375 , 0.5},
              {-0.3125, -0.4375,  -0.3125,  0.3125, -0.1875,  0.3125},
              {-0.1875, -0.1875,  -0.1875,  0.1875, 0,        0.1875},
              {-0.0625, 0,        -0.0625,  0.0625, 0.5,      0.0625},}
  },
  paramtype = "light",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},   -- wire
  after_dig_node = dcircuits.after_dig_connection,
})

minetest.register_node("dcircuits:dcircuits_conIbot_o_from_above",{
  description = "Wire from above",
  inventory_image = "dcircuits_con_down.png",
  tiles = { "dcircuits_con_empty.png", "dcircuits_con_empty.png",
            "dcircuits_con_down.png", "dcircuits_con_down.png",
            "dcircuits_con_down.png", "dcircuits_con_down.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { {-0.5,    -0.5,     -0.5,     0.5,    -0.4375 , 0.5},
              {-0.0625, -0.4375,  -0.0625,  0.0625, 0,        0.0625},
              {-0.1875, 0,        -0.1875,  0.1875, 0.25,     0.1875},
              {-0.3125, 0.25,     -0.3125,  0.3125, 0.5,      0.3125},}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},   -- wire
  after_dig_node = dcircuits.after_dig_connection,
})

minetest.register_node("dcircuits:dcircuits_conIbot_i_to_above",{
  description = "Wire to above",
  inventory_image = "dcircuits_con_up.png",
  tiles = { "dcircuits_con_in.png", "dcircuits_con_in.png",
            "dcircuits_con_up.png", "dcircuits_con_up.png",
            "dcircuits_con_up.png", "dcircuits_con_up.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { {-0.5,    -0.5,     -0.5,     0.5,    -0.4375 , 0.5},
              {-0.3125, -0.4375,  -0.3125,  0.3125, -0.1875,  0.3125},
              {-0.1875, -0.1875,  -0.1875,  0.1875, 0,        0.1875},
              {-0.0625, 0,        -0.0625,  0.0625, 0.5,      0.0625},}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},   -- wire
  after_dig_node = dcircuits.after_dig_connection,
})


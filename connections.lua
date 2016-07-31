local on_place_connect = function(pos, player, itemstack, pointed_thing)
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

minetest.register_node("dcircuits:dcircuits_con_0",{
  description = "Wire",
  inventory_image = "dcircuits_con_0.png",
  tiles = {"dcircuits_con_0.png"},
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
  after_place_node = on_place_connect,
})

minetest.register_node("dcircuits:dcircuits_con_1",{
  description = "Wire",
  inventory_image = "dcircuits_con_1.png",
  tiles = {"dcircuits_con_1.png"},
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

minetest.register_node("dcircuits:dcircuits_con_2",{
  description = "Wire",
  inventory_image = "dcircuits_con_2.png",
  tiles = {"dcircuits_con_2.png"},
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

minetest.register_node("dcircuits:dcircuits_con_3",{
  description = "Wire",
  inventory_image = "dcircuits_con_3.png",
  tiles = {"dcircuits_con_3.png"},
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




minetest.register_node("dcircuits:dcircuits_con_0",{
  description = "Wire",
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
})

minetest.register_node("dcircuits:dcircuits_con_1",{
  description = "Wire",
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


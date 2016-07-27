minetest.register_node("dcircuits:dcircuits_att_not", {
  description = "Attribute Not",
  tiles = {"dcircuits_not.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  after_dig_node = dcircuits.after_dig_connection,
})

minetest.register_node("dcircuits:dcircuits_att_num", {
  description = "Attribute Number",
  tiles = {"dcircuits_num.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  after_dig_node = dcircuits.after_dig_connection,
})

minetest.register_node("dcircuits:dcircuits_att_str", {
  description = "Attribute String",
  tiles = {"dcircuits_str.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  after_dig_node = dcircuits.after_dig_connection,
})
minetest.register_node("dcircuits:dcircuits_att_not", {
  description = "Attribute Not",
  inventory_image = "dcircuits_not.png",
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
  after_place_node = dcircuits.on_place_connect,
})

minetest.register_node("dcircuits:dcircuits_att_num", {
  description = "Attribute Number",
  inventory_image = "dcircuits_num.png",
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
  after_place_node = dcircuits.on_place_connect,
})

minetest.register_node("dcircuits:dcircuits_att_str", {
  description = "Attribute String",
  inventory_image = "dcircuits_str.png",
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
  after_place_node = dcircuits.on_place_connect,
})
minetest.register_node("dcircuits:dcircuits_nod_bool", {
  description = "Node",
  tiles = {"dcircuits_node_bool.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  dcircuits = {
    parents = {"boolean", nil, nil, nil},
    children = {nil, "boolean", "boolean", "boolean"},
    eval = function(inputs, pos, node)
      return {nil, inputs[1], inputs[1], inputs[1]}
    end,
  },
})

minetest.register_node("dcircuits:dcircuits_dis_nod_bool", {
  description = "Node",
  inventory_image = "dcircuits_node_bool.png",
  tiles = {"dcircuits_node_bool.png^dcircuits_disabled.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  dcircuits = {
    parents = {"boolean", nil, nil, nil},
    children = {nil, "boolean", "boolean", "boolean"},
  },
})

minetest.register_node("dcircuits:dcircuits_nod_int", {
  description = "Node",
  tiles = {"dcircuits_node_int.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  dcircuits = {
    parents = {"integer", nil, nil, nil},
    children = {nil, "integer", "integer", "integer"},
    eval = function(inputs, pos, node)
      return {nil, inputs[1], inputs[1], inputs[1]}
    end,
  },
})

minetest.register_node("dcircuits:dcircuits_dis_nod_int", {
  description = "Node",
  inventory_image = "dcircuits_node_int.png",
  tiles = {"dcircuits_node_int.png^dcircuits_disabled.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  dcircuits = {
    parents = {"integer", nil, nil, nil},
    children = {nil, "integer", "integer", "integer"},
  },
})
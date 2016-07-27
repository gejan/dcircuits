minetest.register_node("dcircuits:dcircuits_nod_3", {
  description = "Node",
  tiles = {"dcircuits_node.png"},
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
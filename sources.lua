minetest.register_node("dcircuits:lever_dcircuits_src_on", {
  description = "Lever ON",
  tiles = {"dcircuits_lever_on.png"},
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
    parents = {},
    children = {"boolean", "boolean", "boolean", "boolean"},
    eval = function(inputs, pos, node)
      return {true, true, true, true}
    end,
  },
  on_rightclick = function(pos, node, player, itemstack, pointed_thing)
    node.name = "dcircuits:lever_dcircuits_src_off"
    minetest.swap_node(pos, node)
    dcircuits.update(pos, node)
  end,
  after_dig_node = dcircuits.after_dig_node,
})

minetest.register_node("dcircuits:lever_dcircuits_src_off", {
  description = "Lever OFF",
  tiles = {"dcircuits_lever_off.png"},
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
    parents = {},
    children = {"boolean", "boolean", "boolean", "boolean"},
    eval = function(inputs, pos, node)
      return {false, false, false, false}
    end,
  },
  on_rightclick = function(pos, node, player, itemstack, pointed_thing)
    node.name = "dcircuits:lever_dcircuits_src_on"
    minetest.swap_node(pos, node)
    dcircuits.update(pos, node)
  end,
  after_dig_node = dcircuits.after_dig_node,
})

minetest.register_node("dcircuits:one_way_dcircuits_src_true", {
  description = "One Way True",
  tiles = {"dcircuits_one_way_true.png"},
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
    parents = {},
    children = {nil, nil, "boolean"},
    eval = function(inputs, pos, node)
      return {nil, nil, true}
    end,
  },
  after_dig_node = dcircuits.after_dig_node,
})

minetest.register_node("dcircuits:constant_dcircuits_src_int", {
  description = "Integer Constant",
  tiles = {"dcircuits_constant.png"},
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
    parents = {},
    children = {"integer", "integer", "integer", "integer"},
    eval = function(inputs, pos, node)
      return {inputs[1], inputs[1], inputs[1], inputs[1]}
    end,
  },
  on_rightclick = function(pos, node, player, itemstack, pointed_thing)
    local meta = minetest.get_meta(pos)
    dcircuits.set_values(meta,{itemstack:get_count()})
    dcircuits.update(pos, node)
    return itemstack
  end,
  after_dig_node = dcircuits.after_dig_node,
})












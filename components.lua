minetest.register_node("dcircuits:dcircuits_src_", {
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
  drop = "dcircuits:lever_dcircuits_src_off",
})
--Version 1

minetest.register_node("dcircuits:dcircuits_reg_bool",{
  description = "Register",
  tiles = {"dcircuits_reg_bool.png"},
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
    parents = {"boolean", nil,       nil, "boolean" },
    children = {     nil, nil, "boolean", },
    eval = function(inputs, pos, node)
        return {nil, nil, inputs[1]}
    end
  },
  after_dig_node = dcircuits.after_dig_node,
  on_timer = function(pos)
    dcircuits.update(pos, minetest.get_node(pos), true)
  end
})

--[[
minetest.register_node("dcircuits:dcircuits_dis_reg_bool",{
  description = "Register",
  tiles = {"dcircuits_reg_bool.png^dcircuits_disabled.png"},
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
    parents = {"boolean", nil,       nil, "boolean" },
    children = {     nil, nil, "boolean", },
  },
  after_dig_node = dcircuits.after_dig_node,
}) ]]

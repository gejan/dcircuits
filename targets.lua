minetest.register_node("dcircuits:dcircuits_trg_lamp_on", {
  description = "Lamp ON",
  tiles = {"dcircuits_lamp_on.png"},
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
    parents = {"boolean"},
    children = {},
    disabeld = "dcircuits:dcircuits_dis_trg_lamp_off",
    eval = function(inputs, pos, node)
      if inputs[1] == false then
        node.name = "dcircuits:dcircuits_trg_lamp_off"
        minetest.swap_node(pos, node)
      return {}
      end
    end,
    },
    after_dig_node = dcircuits.after_dig_node,
})

minetest.register_node("dcircuits:dcircuits_trg_lamp_off", {
  description = "Lamp OFF",
  tiles = {"dcircuits_lamp_off.png"},
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
    parents = {"boolean"},
    children = {},
    eval = function(inputs, pos, node)
      if inputs[1] then
        node.name = "dcircuits:dcircuits_trg_lamp_on"
        minetest.swap_node(pos, node)
      return {}
      end
    end
  },
  after_dig_node = dcircuits.after_dig_node,
})

minetest.register_node("dcircuits:dcircuits_dis_trg_lamp_off", {
  description = "Lamp",
  tiles = {"dcircuits_lamp_off.png^dcircuits_disabled.png"},
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
    parents = {"boolean",nil,nil,nil},
    children = {},
  },
})
minetest.register_node("dcircuits:dcircuits_trg_to_mese_on",{
  description = "Converter",
  tiles = {"dcircuits_to_mese_on.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",    
  paramtype2 = "facedir", 
  light_source = 10,
  walkable = true,
  drop = "dcircuits:to_mese_off",
  groups = {not_in_creative_inventory = 1, snappy = 1, oddly_breakable_by_hand = 1},
  mesecons = {receptor = {state = mesecon.state.on, rules = mesecon.rules.default}},
  dcircuits = {
    parents = {"boolean"},
    children = {},
    disabeld = "dcircuits:dcircuits_dis_trg_to_mese_off",
    eval = function(inputs, pos, node)
      if inputs[1] == false then
        node.name = "dcircuits:dcircuits_trg_to_mese_off"
        minetest.swap_node(pos, node)
        mesecon.receptor_off(pos, mesecon.rules.default)
      return {}
      end
    end,
  },
  drop = "dcircuits:dcircuits_dis_trg_to_mese_off",
})

minetest.register_node("dcircuits:dcircuits_trg_to_mese_off",{
  description = "Converter",
  tiles = {"dcircuits_to_mese_off.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",   
  paramtype2 = "facedir", 
  walkable = true,
  groups = {not_in_creative_inventory = 1, snappy = 1, oddly_breakable_by_hand = 1},
  dcircuits = {
    parents = {"boolean"},
    children = {},
    eval = function(inputs, pos, node)
      if inputs[1] == true then
        node.name = "dcircuits:dcircuits_trg_to_mese_on"
        minetest.swap_node(pos, node)
        mesecon.receptor_on(pos, mesecon.rules.default)
      return {}
      end
    end,
  },
  mesecons = {receptor = {state = mesecon.state.off, rules = mesecon.rules.default,}},
  drop = "dcircuits:dcircuits_dis_trg_to_mese_off",
})

minetest.register_node("dcircuits:dcircuits_dis_trg_to_mese_off",{
  description = "Converter",
  tiles = {"dcircuits_to_mese_off.png^dcircuits_disabled.png"},
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
  },
  mesecons = {receptor = {state = mesecon.state.off, rules = mesecon.rules.default,}},
})



minetest.register_node("dcircuits:dcircuits_src_mese_to_on",{
  description = "Converter",
  tiles = {"dcircuits_mese_to_on.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",     
  paramtype2 = "facedir", 
  light_source = 10,
  walkable = true,
  groups = {not_in_creative_inventory = 1, snappy = 1, oddly_breakable_by_hand = 1},
  mesecons = {effector = { rules = mesecon.rules.default,
    action_off = function(pos, node)
        node.name = "dcircuits:dcircuits_src_mese_to_off"
        minetest.swap_node(pos, node)
        dcircuits.update(pos, node)
    end,
  }},
  dcircuits = {
    parents = {},
    children = {"boolean", "boolean", "boolean", "boolean"},
    eval = function(inputs, pos, node)
      return {true, true, true, true}
    end,
  },
  drop = "dcircuits:dcircuits_src_mese_to_off",
})

minetest.register_node("dcircuits:dcircuits_src_mese_to_off",{
  description = "Converter",
  tiles = {"dcircuits_mese_to_off.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",     
  paramtype2 = "facedir", 
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  mesecons = {effector = { rules = mesecon.rules.default,
    action_on = function(pos, node)
        node.name = "dcircuits:dcircuits_src_mese_to_on"
        minetest.swap_node(pos, node)
        dcircuits.update(pos, node) 
    end,
  }},
  dcircuits = {
    parents = {},
    children = {"boolean", "boolean", "boolean", "boolean"},
    eval = function(inputs, pos, node)
      return {false, false, false, false}
    end,
  },
})

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
  groups = {not_in_creative_inventory = 1, snappy = 1, oddly_breakable_by_hand = 1},
  light_source = 13,
  
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
    drop = "dcircuits:dcircuits_dis_trg_lamp_off",
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
  groups = {not_in_creative_inventory = 1, snappy = 1, oddly_breakable_by_hand = 1},
  
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
  drop = "dcircuits:dcircuits_dis_trg_lamp_off",
})

minetest.register_node("dcircuits:dcircuits_dis_trg_lamp_off", {
  description = "Lamp",
  inventory_image = "dcircuits_lamp_off.png",
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
    parents = {"boolean",},
    children = {},
  },
})



-------------------------------------------------------


minetest.register_node("dcircuits:dcircuits_trg_sign_int", {
  description = "Integer Sign",
  tiles = { "dcircuits_sign.png", "dcircuits_sign.png", 
            "dcircuits_sign.png", "dcircuits_sign.png", 
            "dcircuits_sign_back_int.png", "dcircuits_sign.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, 0.5, 0.5, 0.5, 0.375}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {not_in_creative_inventory = 1, snappy = 1, oddly_breakable_by_hand = 1},
  
  dcircuits = {
    parents = {"integer"},
    children = {},
    eval = function(inputs, pos, node)
      local meta = minetest.get_meta(pos)
      meta:set_string("infotext", tostring(inputs[1]))
      return {}
    end
  },
  after_dig_node = dcircuits.after_dig_node,
  drop = "dcircuits:dcircuits_dis_trg_sign_int",
})

minetest.register_node("dcircuits:dcircuits_dis_trg_sign_int", {
  description = "Integer Sign",
  inventory_image = "dcircuits_sign.png^dcircuits_n.png",
  tiles = { "dcircuits_sign.png", "dcircuits_sign.png", 
            "dcircuits_sign.png", "dcircuits_sign.png", 
            "dcircuits_sign_back_int.png", "dcircuits_sign.png^dcircuits_disabled.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, 0.5, 0.5, 0.5, 0.375}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  
  dcircuits = {
    parents = {"integer",},
    children = {},
  },
})

minetest.register_node("dcircuits:dcircuits_trg_sign_str", {
  description = "Sign",
  tiles = { "dcircuits_sign.png", "dcircuits_sign.png", 
            "dcircuits_sign.png", "dcircuits_sign.png", 
            "dcircuits_sign_back_str.png", "dcircuits_sign.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, 0.5, 0.5, 0.5, 0.375}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {not_in_creative_inventory = 1, snappy = 1, oddly_breakable_by_hand = 1},
  
  dcircuits = {
    parents = {"string"},
    children = {},
    eval = function(inputs, pos, node)
      local meta = minetest.get_meta(pos)
      meta:set_string("infotext", tostring(inputs[1]))
      return {}
    end
  },
  after_dig_node = dcircuits.after_dig_node,
  drop = "dcircuits:dcircuits_dis_trg_sign_str",
})

minetest.register_node("dcircuits:dcircuits_dis_trg_sign_str", {
  description = "Sign",
  inventory_image = "dcircuits_sign.png^dcircuits_s.png",
  tiles = { "dcircuits_sign.png", "dcircuits_sign.png", 
            "dcircuits_sign.png", "dcircuits_sign.png", 
            "dcircuits_sign_back_str.png", "dcircuits_sign.png^dcircuits_disabled.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, 0.5, 0.5, 0.5, 0.375}}
  },
  paramtype = "light",
  paramtype2 = "facedir",
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  
  dcircuits = {
    parents = {"string",},
    children = {},
  },
})
















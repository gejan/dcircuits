minetest.register_node("dcircuits:dcircuits_trg_to_digiline",{
  description = "Converter",
  tiles = {"dcircuits_to_digiline.png"},
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
    parents = {"string"},
    children = {},
    eval = function(inputs, pos, node)
      local val = tostring(inputs[1])
      if val then
        local meta = minetest.get_meta(pos)
        local channel = meta:get_string("channel")
        if channel then
          digiline:receptor_send(pos, digiline.rules.default, channel, val)
        end
      return {}
      end
    end,
  },
  digiline = {receptor = {}, effector = {}},
  on_receive_fields = function(pos, formname, fields, sender) 
    local name = sender:get_player_name() 
    if minetest.is_protected(pos, name) and not minetest.check_player_privs(name, {protection_bypass=true}) then 
      minetest.record_protection_violation(pos, name) 
      return 
    end 
    if (fields.channel) then 
      minetest.get_meta(pos):set_string("channel", fields.channel) 
    end 
  end,
  after_dig_node = dcircuits.after_dig_node,
  drop = "dcircuits:dcircuits_dis_trg_to_digiline",
})

minetest.register_node("dcircuits:dcircuits_dis_trg_to_digiline",{
  description = "Converter",
  inventory_image = "dcircuits_to_digiline.png",
  tiles = {"dcircuits_to_digiline.png^dcircuits_disabled.png"},
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
    parents = {"string"},
    children = {},
  },
  digiline = {receptor = {}, effector = {}},
  on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("formspec", "field[channel;Channel;${channel}]")
  end,
  after_dig_node = dcircuits.after_dig_node,
})

minetest.register_node("dcircuits:dcircuits_src_digiline_to",{
  description = "Converter",
  inventory_image = "dcircuits_digiline_to.png",
  tiles = {"dcircuits_digiline_to.png"},
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
  },
  paramtype = "light",     
  paramtype2 = "facedir", 
  walkable = true,
  groups = {snappy = 1, oddly_breakable_by_hand = 1},
  digiline = {receptor = {}, effector = {
      action = function(pos, node, channel, msg)
        local meta = minetest.get_meta(pos)
        local chan = meta:get_string("channel")
        if chan == channel then
          dcircuits.set_values(meta, {msg})
          dcircuits.update(pos, node) 
        end
      end,
  }},
  dcircuits = {
    parents = {},
    children = {"string", "string", "string", "string"},
    eval = function(inputs, pos, node)
      local val = inputs[1]
      if not val then val = "" end
      return {val, val, val, val}
    end,
  },
  on_construct = function(pos) 
    local meta = minetest.get_meta(pos) 
    meta:set_string("formspec", "field[channel;Channel;${channel}]") 
  end,
   on_receive_fields = function(pos, formname, fields, sender) 
    local name = sender:get_player_name() 
    if minetest.is_protected(pos, name) and not minetest.check_player_privs(name, {protection_bypass=true}) then 
      minetest.record_protection_violation(pos, name) 
      return 
    end 
    if (fields.channel) then 
      minetest.get_meta(pos):set_string("channel", fields.channel) 
    end 
  end, 
  after_dig_node = dcircuits.after_dig_node,
})


-- crafting
--///////////////////////

minetest.register_craft({
  output = "dcircuits:dcircuits_dis_trg_to_digiline",
  recipe = {
    {"", "", ""},
    {"dcircuits:dcircuits_con_0", "", ""},
    {"digilines:wire_std_00000000", "", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:dcircuits_src_digiline_to",
  recipe = {
    {"digilines:wire_std_00000000", "", ""},
    {"dcircuits:dcircuits_con_0", "", ""},
    {"", "", ""}
  }
})
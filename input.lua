local input_formspec_int = 
        "size[4,2]"..
        "field[0.5,0.5;3,1;input;Input;${dc_value}]"..
        "button_exit[0.25,1;2,1;save;Save]"
        
local input_formspec_str = 
        "size[4,2]"..
        "field[0.5,0.5;3,1;input;Input;${dc_value}]"..
        "button_exit[0.25,1;2,1;save;Save]"

minetest.register_node("dcircuits:input_dcircuits_src_int", {
  description = "Integer Input Terminal",
  tiles = { "dcircuits_input_int_side.png", "dcircuits_input_int_side.png",
            "dcircuits_input_int_side.png", "dcircuits_input_int_side.png",
            "dcircuits_input_int_side.png", "dcircuits_input_int.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  groups = {snappy = 1, oddly_breakable_by_hand = 1},

  dcircuits = {
    parents = {},
    children = {"integer", "integer", "integer", "integer"},
    eval = function(inputs, pos, node)
      local value =  minetest.get_meta(pos):get_int("dc_value")
      if not value then
        value = 0
      end
      return {value, value, value, value}
    end,
  },
  on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("dc_value", "0")
    meta:set_string("formspec", input_formspec_int)
  end,
  on_receive_fields = function(pos, form_name, fields, player)
    if not fields.save then
      return
    end
    local meta = minetest.get_meta(pos)
    local value = fields.input
    if not tonumber(value) then value = "0" end
    meta:set_string("dc_value", value)
    meta:set_string("infotext", value)
    dcircuits.update(pos, minetest.get_node(pos))
    return true
  end,
  after_dig_node = dcircuits.after_dig_node,
})

minetest.register_node("dcircuits:input_dcircuits_src_str", {
  description = "Input Terminal",
  tiles = { "dcircuits_input_int_side.png", "dcircuits_input_int_side.png",
            "dcircuits_input_int_side.png", "dcircuits_input_int_side.png",
            "dcircuits_input_int_side.png", "dcircuits_input_str.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  groups = {snappy = 1, oddly_breakable_by_hand = 1},

  dcircuits = {
    parents = {},
    children = {"string", "string", "string", "string"},
    eval = function(inputs, pos, node)
      local value = minetest.get_meta(pos):get_string("dc_value")
      if not value then
        value = ""
      end
      return {value, value, value, value}
    end,
  },
  on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("dc_value", "")
    meta:set_string("formspec", input_formspec_str)
  end,
  on_receive_fields = function(pos, form_name, fields, player)
    if not fields.save then
      return
    end
    local meta = minetest.get_meta(pos)
    local value = tostring(fields.input)
    if not value then value = "" end
    meta:set_string("dc_value", value)
    meta:set_string("infotext", value)
    dcircuits.update(pos, minetest.get_node(pos))
    return true
  end,
  after_dig_node = dcircuits.after_dig_node,
})


-- constants
------------------------------------------------------------------

local get_int_constant = function(pos, player, itemstack, pointed_thing)
  local formspec = 
        "size[4,2]"..
        "field[0.5,0.5;3,1;input;Constant;0]"..
        "button_exit[0.25,1;2,1;save;Save]"
  minetest.show_formspec(player:get_player_name(), "dcircuits:input_"..minetest.serialize(pos), formspec)
end

local get_str_constant = function(pos, player, itemstack, pointed_thing)
  local formspec = 
        "size[4,2]"..
        "field[0.5,0.5;3,1;input;Constant;]"..
        "button_exit[0.25,1;2,1;save;Save]"
  minetest.show_formspec(player:get_player_name(), "dcircuits:input_"..minetest.serialize(pos), formspec)
end

minetest.register_on_player_receive_fields(function(player, form_name, fields)
   if not form_name:find"dcircuits:input_" or not fields.save then
      return false
   end
   local s = form_name:sub(17)
   local pos = minetest.deserialize(s)
   local meta = minetest.get_meta(pos)
   meta:set_string("dc_value", fields.input)
   meta:set_string("infotext", tostring(fields.input))
   dcircuits.update(pos, minetest.get_node(pos))
   return true
end)

minetest.register_node("dcircuits:constant_dcircuits_src_int", {
  description = "Integer Constant",
  inventory_image = "dcircuits_constant_int.png",
  tiles = { "dcircuits_constant_int.png"},
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
      local value = minetest.get_meta(pos):get_int("dc_value")
      if not value then
        value = 0
      end
      return {value, value, value, value}
    end,
  },
  after_place_node = get_int_constant,
  after_dig_node = dcircuits.after_dig_node,
})

minetest.register_node("dcircuits:constant_dcircuits_src_str", {
  description = "String Constant",
  inventory_image = "dcircuits_constant_str.png",
  tiles = { "dcircuits_constant_str.png"},
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
    children = {"string", "string", "string", "string"},
    eval = function(inputs, pos, node)
      local value = minetest.get_meta(pos):get_string("dc_value")
      if not value then
        value = ""
      end
      return {value, value, value, value}
    end,
  },
  after_place_node = get_str_constant,
  after_dig_node = dcircuits.after_dig_node,
})






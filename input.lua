local get_input = function(pos, node, player, itemstack, pointed_thing)
  local meta = minetest.get_meta(pos)
  local value = dcircuits.get_values(meta)[1]
  if value == nil then 
    value = "" 
  end
  local formspec = 
        "size[4,2]"..
        "field[0.5,0.5;3,1;input;Input;"..value.."]"..
        "button_exit[0.25,1;2,1;save;Save]"
  minetest.show_formspec(player:get_player_name(), "dcircuits:input_"..minetest.serialize(pos), formspec)
end

local get_constant = function(pos, player, itemstack, pointed_thing)
  local meta = minetest.get_meta(pos)
  local value = dcircuits.get_values(meta)[1]
  if value == nil then 
    value = "" 
  end
  local formspec = 
        "size[4,2]"..
        "field[0.5,0.5;3,1;input;Constant;"..value.."]"..
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
   dcircuits.set_values(meta, {fields.input})
   meta:set_string("infotext", tostring(fields.input))
   dcircuits.update(pos, minetest.get_node(pos))
   return true
end)

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
      local value = tonumber(inputs[1])
      if not value then
        value = 0
      end
      return {value, value, value, value}
    end,
  },
  on_rightclick = get_input,
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
      local value = tostring(inputs[1])
      if not value then
        value = ""
      end
      return {value, value, value, value}
    end,
  },
  on_rightclick = get_input,
  after_dig_node = dcircuits.after_dig_node,
})


-- constants
------------------------------------------------------------------

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
      local value = tonumber(inputs[1])
      if not value then
        value = 0
      end
      return {value, value, value, value}
    end,
  },
  after_place_node = get_constant,
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
      local value = tostring(inputs[1])
      if not value then
        value = ""
      end
      return {value, value, value, value}
    end,
  },
  after_place_node = get_constant,
  after_dig_node = dcircuits.after_dig_node,
})






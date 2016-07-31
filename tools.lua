dcircuits.use_connect = function(itemstack, user, pointed_thing)
  if pointed_thing.type ~= "node" then
    return itemstack
  end
  local pos = pointed_thing.under
  if minetest.is_protected(pos, user) then
    return itemstack
  end
  local node = minetest.get_node(pos)
  if node.name:find("dcircuits_dis_") or node.name:find("dcircuits_reg_") then
    dcircuits.connect(pos, node, user)
  end
  return itemstack
end

minetest.register_craftitem("dcircuits:stick_stick",{
  description = "Stick Stick",
  inventory_image = "dcircuits_stick_stick.png",
  stack_max = 1,
  on_use = dcircuits.use_connect,
})

minetest.register_craftitem("dcircuits:meta_stick",{
  description = "Meta Stick",
  inventory_image = "dcircuits_stick_stick.png",
  stack_max = 1,
  on_use = function(itemstack, user, pointed_thing)
    if pointed_thing.type ~= "node" then
      return itemstack
    end
    local meta = minetest.get_meta(pointed_thing.under)
    minetest.chat_send_player(user:get_player_name(), "META:"..minetest.serialize(meta:to_table()))
    local node = minetest.get_node(pointed_thing.under)
    minetest.chat_send_player(user:get_player_name(), "PARAM1:"..node.param1)
    minetest.chat_send_player(user:get_player_name(), "PARAM2:"..node.param2)
    return itemstack
  end,
})
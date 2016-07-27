
dcircuits.visited = {}

local begin_visit = function()
  dcircuits.visited = {}
end

local get_visited = function(pos)
  for i = 1, #dcircuits.visited do
    if dcircuits.visited[i] == pos then
      return true
    end
  end
  return false
end

local set_visited = function(pos)
  table.insert(dcircuits.visited, pos)
end


dcircuits.follow = function(pos, facedir)
 local att = nil
 local pos = vector.add(pos, minetest.facedir_to_dir(facedir))
 begin_visit()
 while true do
  local node = minetest.get_node(pos)
  local defpos = node.name:find("dcircuits_")
  if not defpos then
    return {error = "dead end", node = node, pos = pos, attribute = att}
  else
    local def = node.name:sub(defpos)
    local head = def:sub(11,14)
    if head == "con_" then
      if dcircuits_cycle_checking and get_visited(pos) then
        return {error = "cycle", node = node, pos = pos, attribute = att}
      end
      local newdir = node.param2
      local connection = tonumber(def:sub(15,15))
      if (connection > 0) and (((newdir + connection - 2) % 4) == facedir) then
        facedir = newdir
        pos = vector.add(pos, minetest.facedir_to_dir(facedir))
      else
        return {error = "wrong connected wires", node = node, pos = pos, attribute = att}
      end
      set_visited(pos)
    elseif head == "att_" then
      if node.param2 == facedir then
        if att then
          return {error = "multiple attributes", node = node, pos = pos, attribute = att}
        else
          att = def:sub(15,17)
          --facedir := facedir
          pos = vector.add(pos, minetest.facedir_to_dir(facedir))
        end
      end
    elseif head == "nod_" then
      return {node = node, pos = pos, attribute = att, dir = (facedir - node.param2 + 2) % 4}
    elseif head == "src_" then
      return {node = node, pos = pos, attribute = att, dir = (facedir - node.param2 + 2) % 4}
    elseif head == "gat_" then
      return {node = node, pos = pos, attribute = att, dir = (facedir - node.param2 + 2) % 4}
    elseif head == "reg_" then
      return {node = node, pos = pos, attribute = att, dir = (facedir - node.param2 + 2) % 4}
    elseif head == "dis_" then
      return {error = "predecessor not enabled", node = node, pos = pos, attribute = att}
    elseif head == "trg_" then
      return {error = "connecting another effector", node = node, pos = pos, attribute = att}
    else
      return {error = "unknown element", node = node, pos = pos, attribute = att}
    end
  end
 end
end


dcircuits.add_parent = function(pos, dir, target_pos, target_dir)
  local meta = minetest.get_meta(pos)
  meta:set_string("dc_p_"..dir.."_pos", minetest.serialize(target_pos))
  meta:set_int("dc_p_"..dir.."_dir", target_dir)
end

dcircuits.add_child = function(pos, dir, target_pos, target_dir, att)
  local meta = minetest.get_meta(pos)
  meta:set_string("dc_c_"..dir.."_pos", minetest.serialize(target_pos))
  meta:set_int("dc_c_"..dir.."_dir", target_dir)
  if att then
    meta:set_string("dc_c_"..dir.."_att", att)
  end
end


local attribute_match = function(type, att)
  if     type == "boolean" then return (att == nil) or (att == "not") 
  elseif type == "integer" then return att == "num" 
  elseif type == "string"  then return att == "str"
  else                          return false 
  end
end


dcircuits.connect = function(pos, node, player)
  local ddef = minetest.registered_nodes[node.name].dcircuits
  local parent_list = {}
  for i = 1, 4 do
    local dir = i - 1
    local realdir = (dir + node.param2) % 4
    if ddef.parents[i] then
      local parent = dcircuits.follow(pos, realdir)
      if parent.error then
        minetest.chat_send_player(player:get_player_name(), "FAILURE: "..parent.error.." near "..parent.node.name.." at "..minetest.serialize(parent.pos))
        return
      end
      local parent_def = minetest.registered_nodes[parent.node.name].dcircuits
      if  ddef.parents[i] == parent_def.children[parent.dir + 1] then
        if attribute_match(ddef.parents[i], parent.attribute) then
          dcircuits.add_parent(pos, dir, parent.pos, parent.dir)
          table.insert(parent_list, parent)
          if parent.attribute == "not" then
            dcircuits.add_child(parent.pos, parent.dir, pos, dir, "not")
          else
            dcircuits.add_child(parent.pos, parent.dir, pos, dir, nil)
          end
        else
          minetest.chat_send_player(player:get_player_name(), "FAILURE: type mismatch (II): wrong attribute "..tostring(parent.att).." near "..parent.node.name.." at "..minetest.serialize(parent.pos))
        return
        end
      else
        minetest.chat_send_player(player:get_player_name(), "FAILURE: type mismatch (I): "..tostring(ddef.parents[i]).." not equal "..tostring(parent_def.children[parent.dir+1]).." near "..parent.node.name.." at "..minetest.serialize(parent.pos))
        return
      end
    end
  end
  node.name = node.name:gsub("dcircuits_dis_", "dcircuits_")
  minetest.swap_node(pos, node)
  for i = 1, 4 do
    if parent_list[i] then
      dcircuits.update(parent_list[i].pos, parent_list[i].node)
    end
  end
end

------------------------------------------------------

dcircuits.use_connect = function(itemstack, user, pointed_thing)
  if pointed_thing.type ~= "node" then
    return itemstack
  end
  local pos = pointed_thing.under
  if minetest.is_protected(pos, user) then
    return itemstack
  end
  local node = minetest.get_node(pos)
  if node.name:find("dcircuits_dis_") then
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

-----------------------------------------------------------


dcircuits.get_values = function(meta)
  local s = minetest.deserialize(meta:get_string("dc_v"))
  if s == nil then
    return {}
  else
    return s
  end
end

dcircuits.set_values = function(meta, values)
  meta:set_string("dc_v", minetest.serialize(values))
end

dcircuits.update = function(pos, node)
  if not node.name:find("dcircuits_")  then
    minetest.chat_send_all("DCircuit: circuit broken!")
    return
  end
  if (node.name:find("dcircuits_dis") or node.name:find("dcircuits_reg")) then
    --TODO
    return
  end
  local ddef = minetest.registered_nodes[node.name].dcircuits
  local meta = minetest.get_meta(pos)
  local inputs = dcircuits.get_values(meta)
  local outputs = ddef.eval(inputs, pos, node)
  local updates = {}
  for i = 1, 4 do
    if ddef.children[i] then
      local child_pos = minetest.deserialize(meta:get_string("dc_c_"..(i - 1).."_pos"))
      if child_pos then
        local child_meta = minetest.get_meta(child_pos)
        local values = dcircuits.get_values(child_meta)
        if meta:get_string("dc_c_"..(i - 1).."_att") == "not" then
          outputs[i] = not outputs[i]
        end    
        if values[meta:get_int(("dc_c_"..(i - 1).."_dir")) + 1] ~= outputs[i] then
          values[meta:get_int(("dc_c_"..(i - 1).."_dir")) + 1] = outputs[i] 
          dcircuits.set_values(child_meta, values)
          updates[i]=child_pos
        end  
      end
    end
  end
  for i = 1, 4 do
    if updates[i] then
      node = minetest.get_node(updates[i])
      dcircuits.update(updates[i], node)
    end
  end
end

dcircuits.disable = function(pos, node)
  if not node.name:find("dcircuits_")  then
    return
  end
  if node.name:find("dcircuits_dis") then
    return
  end
  local ddef = minetest.registered_nodes[node.name].dcircuits
  
  if ddef.disabeld then
    node.name = ddef.disabeld
    minetest.swap_node(pos, node)
  else
    node.name = node.name:gsub("dcircuits_", "dcircuits_dis_")
    minetest.swap_node(pos, node)
  end
  
  --disable all children
  local meta = minetest.get_meta(pos)
  for i = 1, 4 do
    if ddef.children[i] then
      local child_pos = minetest.deserialize(meta:get_string("dc_c_"..(i - 1).."_pos"))
      if child_pos then
        dcircuits.disable(child_pos, minetest.get_node(child_pos))
      end
    end
  end
end

dcircuits.disable_children = function(pos, node_def, meta)
  for i = 1, 4 do
    if node_def.children[i] then
      local child_pos = minetest.deserialize(meta:get_string("dc_c_"..(i - 1).."_pos"))
      if child_pos then
        dcircuits.disable(child_pos, minetest.get_node(child_pos))
      end
    end
  end
end

dcircuits.after_dig_node = function(pos, node, metadata, player)
  local ddef = minetest.registered_nodes[node.name].dcircuits
  local meta = minetest.get_meta(pos)
  meta:from_table(metadata)
  dcircuits.disable_children(pos, ddef, meta)
  meta:from_table(nil)
end

dcircuits.after_dig_connection = function(pos, node, metadata, player)
  return
end

if dcircuits.config.disable_on_dig_connection then
  dcircuits.after_dig_connection = function(pos, node, metadata, player)
    local parent = dcircuits.follow(pos, node.param2)
    if parent.error then
      return
    end
    local ddef = minetest.registered_nodes[parent.node.name].dcircuits
    local meta = minetest.get_meta(parent.pos)
    dcircuits.disable_children(pos, ddef, meta)
  end
end




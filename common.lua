
dcircuits.visited = {}

local begin_visit = function()
  dcircuits.visited = {}
end

local get_visited = function(pos)
  for i = 1, #dcircuits.visited do
    if vector.equals(dcircuits.visited[i], pos) then
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
 local imm = true
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
      if dcircuits.config.cycle_checking and get_visited(pos) then
        return {error = "cycle", node = node, pos = pos, attribute = att}
      end
      set_visited(pos)
      imm = false
      local newdir = node.param2
      local connection = tonumber(def:sub(15,15))
      if (connection > 0) and (((newdir + connection - 2) % 4) == facedir) then
        facedir = newdir
        pos = vector.add(pos, minetest.facedir_to_dir(facedir))
      else
        return {error = "wrong connected wires", node = node, pos = pos, attribute = att}
      end
    elseif head == "conI" then  
      if dcircuits.config.cycle_checking and get_visited(pos) then
        return {error = "cycle", node = node, pos = pos, attribute = att}
      end
      set_visited(pos)
      imm = false
      local con_def = def:sub(15, 20)
      if con_def == "cross_" then
        if node.param2 == facedir or (node.param2 + 3) % 4 == facedir then
          pos = vector.add(pos, minetest.facedir_to_dir(facedir))
        else
          return {error = "wrong connected wires", node = node, pos = pos, attribute = att}
        end
      elseif con_def == "arw_d_" then
        if facedir == 4 then
          pos = vector.add(pos, {x=0, y=1, z=0})
        else
          return {error = "wrong connected wires", node = node, pos = pos, attribute = att}
        end
      elseif con_def == "arw_u_" then
        if facedir == 5 then
          pos = vector.add(pos, {x=0, y=-1, z=0})
        else
          return {error = "wrong connected wires", node = node, pos = pos, attribute = att}
        end
      elseif con_def == "bot_i_" then
        if facedir == 5 then
          facedir = (node.param2 + 2) % 4
          pos = vector.add(pos, minetest.facedir_to_dir(facedir))
        else
          return {error = "wrong connected wires", node = node, pos = pos, attribute = att}
        end
      elseif con_def == "top_i_" then
        if facedir == 4 then
          facedir = node.param2
          pos = vector.add(pos, minetest.facedir_to_dir(facedir))
        else
          return {error = "wrong connected wires", node = node, pos = pos, attribute = att}
        end
      elseif con_def == "bot_o_" then
        if facedir == node.param2 then
          facedir = 4
          pos = vector.add(pos, {x=0, y=1, z=0})
        else
          return {error = "wrong connected wires", node = node, pos = pos, attribute = att}
        end
      elseif con_def == "top_o_" then
        if facedir == node.param2 then
          facedir = 5
          pos = vector.add(pos, {x=0, y=-1, z=0})
        else
          return {error = "wrong connected wires", node = node, pos = pos, attribute = att}
        end
      else
        return {error = "unknown wire", node = node, pos = pos, attribute = att}
      end
    elseif head == "att_" then
      if node.param2 == facedir then
        if att then
          return {error = "multiple attributes", node = node, pos = pos, attribute = att}
        end
        if dcircuits.config.cycle_checking and get_visited(pos) then
          return {error = "cycle", node = node, pos = pos, attribute = att}
        end
        set_visited(pos)
        imm = false
        
        att = def:sub(15,17)
        --facedir := facedir
        pos = vector.add(pos, minetest.facedir_to_dir(facedir))
      else
        return {error = "wrong connected attribute", node = node, pos = pos, attribute = att}
      end
    elseif head == "nod_" then
      return {node = node, pos = pos, attribute = att, dir = (facedir - node.param2 + 2) % 4, imm = imm}
    elseif head == "src_" then
      return {node = node, pos = pos, attribute = att, dir = (facedir - node.param2 + 2) % 4, imm = imm}
    elseif head == "gat_" then
      return {node = node, pos = pos, attribute = att, dir = (facedir - node.param2 + 2) % 4, imm = imm}
    elseif head == "reg_" then
      return {node = node, pos = pos, attribute = att, dir = (facedir - node.param2 + 2) % 4, imm = imm}
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

dcircuits.remove_child = function(meta, dir)
  meta:set_string("dc_c_"..dir.."_pos", nil)
  meta:set_string("dc_c_"..dir.."_dir", nil)
  meta:set_string("dc_c_"..dir.."_att", nil)
end


local attribute_match 

if dcircuits.config.type_attribute_mode == "no_check" then
  attribute_match = function(type, att, imm)
    return true
  end
elseif dcircuits.config.type_attribute_mode == "check" then
  attribute_match = function(type, att, imm)
    if     type == "boolean" then return (att == nil) or (att == "not") 
    elseif type == "integer" then return (att == nil) or (att == "num") 
    elseif type == "string"  then return (att == nil) or (att == "str")
    else                          return false 
    end
  end
elseif dcircuits.config.type_attribute_mode == "direct" then
  attribute_match = function(type, att, imm)
    if imm then return true
    elseif type == "boolean" then return (att == nil) or (att == "not") 
    elseif type == "integer" then return att == "num" 
    elseif type == "string"  then return att == "str"
    else                          return false 
    end
  end
elseif dcircuits.config.type_attribute_mode == "strong" then
  attribute_match = function(type, att, imm)
    if     type == "boolean" then return (att == nil) or (att == "not") 
    elseif type == "integer" then return att == "num" 
    elseif type == "string"  then return att == "str"
    else                          return false 
    end
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
        if attribute_match(ddef.parents[i], parent.attribute, parent.imm) then
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
    minetest.chat_send_all("DCircuit: circuit broken at"..minetest.serialize(pos))
    return
  end
  if node.name:find("dcircuits_dis") then
    return
  end
  --if not step and node.name:find("dcircuits_reg") then
  --   minetest.get_node_timer(pos):set(1,0)
  --  return
  --end
  
  local ddef = minetest.registered_nodes[node.name].dcircuits
  local meta = minetest.get_meta(pos)
  local inputs = dcircuits.get_values(meta)
  
  --initial values for e.g. integer input
  for i = 1, 4 do 
    local type = ddef.parents[i]
    if type == "boolean" then
      if inputs[i] ~= true then
        inputs[i] = false
      end
    elseif type == "integer" then
      if not tonumber(inputs[i]) then
        inputs[i] = 0
      end
    elseif type == "string" then
      if not tostring(inputs[i]) then
        inputs[i] = ""
      end
    end
  end
  
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
        local child_dir = meta:get_int(("dc_c_"..(i - 1).."_dir")) + 1
        if values[child_dir] ~= outputs[i] then
          values[child_dir] = outputs[i] 
          dcircuits.set_values(child_meta, values)
          local child_node = minetest.get_node(child_pos)
          if child_node.name:find("dcircuits_reg_") then
            if child_dir == 4 and values[child_dir] then
              minetest.get_node_timer(child_pos):set(1,0)
            end
          else
            updates[i] = child_pos
          end
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
  if metadata then
    meta:from_table(metadata)
    for i = 1, 4 do
      if ddef.parents[i] then
        local p_pos = minetest.deserialize(meta:get_string("dc_p_"..(i - 1).."_pos"))
        local p_dir = meta:get_int("dc_p_"..(i - 1).."_dir")
        dcircuits.remove_child(meta, p_dir)
      end
    end
  end
  
  dcircuits.disable_children(pos, ddef, meta)
  meta:from_table(nil)
end

dcircuits.after_dig_connection = function(pos, node, metadata, player)
  return
end

if dcircuits.config.disable_on_dig_connection then
  dcircuits.after_dig_connection = function(pos, node, metadata, player)
    
    local facedir = node.param2
    local q local p 
    q, p = node.name:find("dcircuits_conI")
    if p then
      local d = node.name:sub(p + 1, p + 6)
      if d == "cross_" then
        local parent = dcircuits.follow(pos, facedir)
        if parent.error then
          return
        end
        local ddef = minetest.registered_nodes[parent.node.name].dcircuits
        local meta = minetest.get_meta(parent.pos)
        dcircuits.disable_children(pos, ddef, meta)
        facedir = (facedir + 3) % 4
      elseif d == "arw_d_" or d == "bot_o_"then
        facedir = 4
      elseif d == "arw_u_" or d == "bot_i_"then
        facedir = 5
      end
    end
    local parent = dcircuits.follow(pos, facedir)
    if parent.error then
      return
    end
    local ddef = minetest.registered_nodes[parent.node.name].dcircuits
    local meta = minetest.get_meta(parent.pos)
    dcircuits.disable_children(pos, ddef, meta)
  end
end




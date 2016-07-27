dcircuits.register_gate = function(name, def)
  if (not def.description) or (not def.texture) or (not def.dcircuits) then
    return
  end
  minetest.register_node("dcircuits:dcircuits_gat_"..name, {
    description = def.description,
    tiles = {def.texture},
    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
    },
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    groups = {snappy = 1, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1,},
    dcircuits = def.dcircuits,
    after_dig_node = dcircuits.after_dig_node,
    drop = "dcircuits:dcircuits_dis_gat_"..name,
  })
  minetest.register_node("dcircuits:dcircuits_dis_gat_"..name, {
    description = def.description,
    tiles = {def.texture.."^dcircuits_disabled.png"},
    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375 , 0.5}}
    },
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    groups = {snappy = 1, oddly_breakable_by_hand = 1},
    dcircuits = def.dcircuits,
    after_dig_node = dcircuits.after_dig_node,
  }) 
end

dcircuits.register_gate("and", {
  description = "AND Gate",
  texture = "dcircuits_and.png",
  dcircuits = {
    parents = {nil, "boolean", nil, "boolean"},
    children = {nil, nil, "boolean", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2] and inputs[4]}
    end,
  },
})

dcircuits.register_gate("or", {
  description = "OR Gate",
  texture = "dcircuits_or.png",
  dcircuits = {
    parents = {nil, "boolean", nil, "boolean"},
    children = {nil, nil, "boolean", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2] or inputs[4]}
    end,
  },
})

dcircuits.register_gate("xor", {
  description = "XOR Gate",
  texture = "dcircuits_xor.png",
  dcircuits = {
    parents = {nil, "boolean", nil, "boolean"},
    children = {nil, nil, "boolean", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2] ~= inputs[4]}
    end,
  },
})

dcircuits.register_gate("add", {
  description = "Adder",
  texture = "dcircuits_add.png",
  dcircuits = {
    parents = {nil, "integer", nil, "integer"},
    children = {nil, nil, "integer", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2] + inputs[4]}
    end,
  },
})

dcircuits.register_gate("eq", {
  description = "Equals",
  texture = "dcircuits_eq.png",
  dcircuits = {
    parents = {nil, "integer", nil, "integer"},
    children = {nil, nil, "boolean", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2] == inputs[4]}
    end,
  },
})

dcircuits.register_gate("less", {
  description = "Less",
  texture = "dcircuits_less.png",
  dcircuits = {
    parents = {nil, "integer", nil, "integer"},
    children = {nil, nil, "boolean", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2] < inputs[4]}
    end,
  },
})

dcircuits.register_gate("sub", {
  description = "Subtracter",
  texture = "dcircuits_sub.png",
  dcircuits = {
    parents = {nil, "integer", nil, "integer"},
    children = {nil, nil, "integer", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2] - inputs[4]}
    end,
  },
})

dcircuits.register_gate("mul", {
  description = "Multiplier",
  texture = "dcircuits_mul.png",
  dcircuits = {
    parents = {nil, "integer", nil, "integer"},
    children = {nil, nil, "integer", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2] * inputs[4]}
    end,
  },
})

dcircuits.register_gate("div", {
  description = "Divider",
  texture = "dcircuits_div.png",
  dcircuits = {
    parents = {nil, "integer", nil, "integer"},
    children = {nil, nil, "integer", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2] * inputs[4]}
    end,
  },
})

dcircuits.register_gate("mod", {
  description = "Modulo",
  texture = "dcircuits_mod.png",
  dcircuits = {
    parents = {nil, "integer", nil, "integer"},
    children = {nil, nil, "integer", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2] % inputs[4]}
    end,
  },
})

dcircuits.register_gate("concat", {
  description = "Linker",
  texture = "dcircuits_concat.png",
  dcircuits = {
    parents = {nil, "string", nil, "string"},
    children = {nil, nil, "string", nil},
    eval = function(inputs, pos, node)
      return {nil, nil, inputs[2]..inputs[4]}
    end,
  },
})


























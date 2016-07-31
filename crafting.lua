
-- connections
--////////////////////////////
minetest.register_craft({
  output = "dcircuits:dcircuits_con_0 16",
  recipe = {
    {"default:mese_crystal_fragment", "default:steel_ingot", "default:mese_crystal_fragment"},
    {"default:steel_ingot", "default:mese_crystal_fragment", "default:steel_ingot"},
    {"default:mese_crystal_fragment", "default:steel_ingot", "default:mese_crystal_fragment"}
  }
})

minetest.register_craft({
  output = "dcircuits:dcircuits_con_1",
  recipe = {
    {"dcircuits:dcircuits_con_0", "", ""},
    {"dcircuits:dcircuits_con_0", "dcircuits:dcircuits_con_0", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:dcircuits_con_2",
  recipe = {
    {"dcircuits:dcircuits_con_0", "", ""},
    {"dcircuits:dcircuits_con_0", "", ""},
    {"dcircuits:dcircuits_con_0", "", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:dcircuits_con_3",
  recipe = {
    {"",                          "dcircuits:dcircuits_con_0", ""},
    {"dcircuits:dcircuits_con_0", "dcircuits:dcircuits_con_0", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:dcircuits_conIcross_x",
  recipe = {
    {"dcircuits:dcircuits_con_0", "", "dcircuits:dcircuits_con_0"},
    {"",                    "dcircuits:dcircuits_con_0", ""},
    {"dcircuits:dcircuits_con_0", "", "dcircuits:dcircuits_con_0"}
  }
})

minetest.register_craft({
  output = "dcircuits:dcircuits_conIarw_u_up",
  recipe = {
    {"", "", ""},
    {"",                    "dcircuits:dcircuits_con_0", ""},
    {"dcircuits:dcircuits_con_0", "", "dcircuits:dcircuits_con_0"}
  }
})

minetest.register_craft({
  output = "dcircuits:dcircuits_conIarw_d_down",
  recipe = {
    {"dcircuits:dcircuits_con_0", "", "dcircuits:dcircuits_con_0"},
    {"",                    "dcircuits:dcircuits_con_0", ""},
    {"", "", ""}
  }
})


-- attributes
--////////////////////////////

minetest.register_craft({
  output = "dcircuits:dcircuits_att_not",
  recipe = {
    {"dcircuits:dcircuits_con_0", "default:mese_crystal_fragment", "dcircuits:dcircuits_con_0"},
    {"", "", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:dcircuits_att_num",
  recipe = {
    {"dcircuits:dcircuits_con_0", "dcircuits:dcircuits_con_0", "dcircuits:dcircuits_con_0"},
    {"dcircuits:dcircuits_con_0", "dcircuits:dcircuits_con_0", "dcircuits:dcircuits_con_0"},
    {"", "", ""}
  }
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_att_str",
  recipe = {"dcircuits:dcircuits_att_num"}
})


-- nodes
--////////////////////////////

minetest.register_craft({
  output = "dcircuits:dcircuits_dis_nod_bool",
  recipe = {
    {"",                          "dcircuits:dcircuits_con_0", ""},
    {"dcircuits:dcircuits_con_0", "dcircuits:dcircuits_con_0", "dcircuits:dcircuits_con_0"},
    {"",                          "dcircuits:dcircuits_con_0", ""}
  }
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_nod_int",
  recipe = {"dcircuits:dcircuits_dis_nod_bool", "dcircuits:dcircuits_att_num"}
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_nod_str",
  recipe = {"dcircuits:dcircuits_dis_nod_bool", "dcircuits:dcircuits_att_str"}
})


-- gates
--////////////////////////////

minetest.register_craft({
  output = "dcircuits:dcircuits_dis_gat_and",
  recipe = {
    {"", "", ""},
    {"dcircuits:dcircuits_con_0", "default:mese_crystal_fragment", "dcircuits:dcircuits_con_0"},
    {"",                          "dcircuits:dcircuits_con_0", ""}
  }
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_or",
  recipe = {"dcircuits:dcircuits_dis_gat_and"}
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_xor",
  recipe = {"dcircuits:dcircuits_dis_gat_or"}
})

minetest.register_craft({
  output = "dcircuits:dcircuits_dis_gat_cond_bool",
  recipe = {
    {"dcircuits:dcircuits_dis_gat_and", "dcircuits:dcircuits_dis_gat_or", ""},
    {"", "", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_cond_int",
  recipe = {"dcircuits:dcircuits_dis_gat_cond_bool", "dcircuits:dcircuits_att_num"}
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_cond_str",
  recipe = {"dcircuits:dcircuits_dis_gat_cond_bool", "dcircuits:dcircuits_att_str"}
})

minetest.register_craft({
  output = "dcircuits:dcircuits_dis_gat_add",
  recipe = {
    {"dcircuits:dcircuits_dis_gat_and", "dcircuits:dcircuits_dis_gat_xor", ""},
    {"", "", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_sub",
  recipe = {"dcircuits:dcircuits_dis_gat_add"}
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_mul",
  recipe = {"dcircuits:dcircuits_dis_gat_sub"}
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_div",
  recipe = {"dcircuits:dcircuits_dis_gat_mul"}
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_mod",
  recipe = {"dcircuits:dcircuits_dis_gat_div"}
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_eq",
  recipe = {"dcircuits:dcircuits_dis_gat_xor", "dcircuits:dcircuits_att_num"}
})

minetest.register_craft({
  output = "dcircuits:dcircuits_dis_gat_less",
  recipe = {
    {"dcircuits:dcircuits_dis_gat_sub", "dcircuits:dcircuits_dis_gat_eq", ""},
    {"", "", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_str_eq",
  recipe = {"dcircuits:dcircuits_dis_gat_xor", "dcircuits:dcircuits_att_str"}
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_dis_gat_concat",
  recipe = {"dcircuits:dcircuits_dis_gat_and", "dcircuits:dcircuits_att_str"}
})

minetest.register_craft({
  output = "dcircuits:dcircuits_dis_gat_select",
  recipe = {
    {"dcircuits:dcircuits_att_num", "dcircuits:dcircuits_dis_gat_and", "dcircuits:dcircuits_att_str"},
    {"", "", ""},
    {"", "", ""}
  }
})


-- tools
--////////////////////////////

minetest.register_craft({
  output = "dcircuits:stick_stick",
  recipe = {
    {"", "", ""},
    {"dcircuits:dcircuits_con_0", "", ""},
    {"default:stick", "", ""}
  }
})


-- sources / inputs
--////////////////////////////

minetest.register_craft({
  output = "dcircuits:lever_dcircuits_src_off",
  recipe = {
    {"default:mese_crystal_fragment", "default:stick", ""},
    {"dcircuits:dcircuits_con_0", "", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:input_dcircuits_src_int",
  recipe = {
    {"default:sign_wall_wood", "", ""},
    {"dcircuits:dcircuits_att_num", "", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:input_dcircuits_src_str",
  recipe = {
    {"default:sign_wall_wood", "", ""},
    {"dcircuits:dcircuits_att_str", "", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:constant_dcircuits_src_int",
  recipe = {
    {"default:sign_wall_wood", "default:steel_ingot", ""},
    {"dcircuits:dcircuits_att_num", "", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:constant_dcircuits_src_str",
  recipe = {
    {"default:sign_wall_wood", "default:steel_ingot", ""},
    {"dcircuits:dcircuits_att_str", "", ""},
    {"", "", ""}
  }
})


-- targets
--////////////////////////////

minetest.register_craft({
  output = "dcircuits:dcircuits_dis_trg_lamp_off",
  recipe = {
    {"",              "default:glass", ""},
    {"default:glass", "default:mese_crystal", "default:glass"},
    {"",              "dcircuits:dcircuits_con_0", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:dcircuits_dis_trg_sign_int",
  recipe = {
    {"dcircuits:dcircuits_att_num", "", ""},
    {"default:sign_wall_wood", "", ""},
    {"", "", ""}
  }
})

minetest.register_craft({
  output = "dcircuits:dcircuits_dis_trg_sign_str",
  recipe = {
    {"dcircuits:dcircuits_att_str", "", ""},
    {"default:sign_wall_wood", "", ""},
    {"", "", ""}
  }
})


-- registers
--////////////////////////////

minetest.register_craft({
  output = "dcircuits:dcircuits_reg_bool",
  recipe = {
    {"",                          "dcircuits:dcircuits_con_0", ""},
    {"dcircuits:dcircuits_con_0", "default:mese_crystal", ""},
    {"",                          "dcircuits:dcircuits_con_0", ""}
  }
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_reg_int",
  recipe = {"dcircuits:dcircuits_reg_bool", "dcircuits:dcircuits_att_num"}
})

minetest.register_craft({
  type = "shapeless",
  output = "dcircuits:dcircuits_reg_str",
  recipe = {"dcircuits:dcircuits_reg_bool", "dcircuits:dcircuits_att_str"}
})






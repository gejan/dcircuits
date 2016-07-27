dcircuits = {}









dcircuits.config = {}
dcircuits.config.cycle_checking = false             -- not really impl
dcircuits.config.replace_connections = false        -- not impl
dcircuits.config.disable_on_dig_connection = true
dcircuits.config.type_attribute_mode = "strong"                   -- "no_check", "check", "direct", "strong"
dcircuits.config.require_type_attribute = {"integer", "string"}   -- 

local path = minetest.get_modpath("dcircuits")
dofile(path.."/common.lua")
dofile(path.."/sources.lua")
dofile(path.."/connections.lua")
dofile(path.."/attributes.lua")
dofile(path.."/gates.lua")
dofile(path.."/nodes.lua")
dofile(path.."/registers.lua")
dofile(path.."/targets.lua")
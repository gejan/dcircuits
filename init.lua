dcircuits = {}

dcircuits.config = {}

dcircuits.config.cycle_checking = false               -- experimental
dcircuits.config.replace_connections = "specialize"     -- "none" | "specialize" | "dissolve" -- experimental
dcircuits.config.disable_on_dig_connection = true     -- has no impact if replace_connections = "dissolve" 
dcircuits.config.type_attribute_mode = "direct"       -- "no_check" | "check" | "direct" | "strong"

local path = minetest.get_modpath("dcircuits")
dofile(path.."/common.lua")
dofile(path.."/tools.lua")
dofile(path.."/sources.lua")
  dofile(path.."/input.lua")
dofile(path.."/connections.lua")
dofile(path.."/attributes.lua")
dofile(path.."/gates.lua")
dofile(path.."/nodes.lua")
dofile(path.."/registers.lua")
dofile(path.."/targets.lua")
dofile(path.."/crafting.lua")

if mesecon then
  dofile(path.."/mesecons.lua")
end

if digiline then
  dofile(path.."/digilines.lua")
end

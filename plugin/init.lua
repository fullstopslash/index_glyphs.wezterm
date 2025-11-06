-- WezTerm Plugin Entry Point
-- This file is required by WezTerm when loading the plugin from GitHub

-- Get the directory where this init.lua file is located
local path = debug.getinfo(1, "S").source:match("@?(.*/)")
if path then
	package.path = package.path .. ';' .. path .. '?.lua;' .. path .. '?.wez.lua'
	local ok, result = pcall(dofile, path .. 'index_glyphs.wez.lua')
	if ok and result then
		return result
	end
end

-- Fallback: return empty table if loading fails
return {}

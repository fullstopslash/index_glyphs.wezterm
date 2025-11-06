-- WezTerm Plugin Entry Point
-- This file is required by WezTerm when loading the plugin from GitHub

-- Try to get the directory containing this file
local init_path = debug.getinfo(1, "S").source
if init_path:match("^@") then
	init_path = init_path:sub(2)  -- Remove @ prefix
end

local plugin_dir = init_path:match("(.*/)") or ""

-- Try loading the plugin file directly
local ok, result = pcall(function()
	-- First try dofile with full path
	local plugin_file = plugin_dir .. "index_glyphs.wez.lua"
	local file = io.open(plugin_file, "r")
	if file then
		file:close()
		return dofile(plugin_file)
	end
	
	-- Fallback: try require
	package.path = package.path .. ';' .. plugin_dir .. '?.lua;' .. plugin_dir .. '?.wez.lua'
	return require('index_glyphs')
end)

if ok and result and type(result) == "table" then
	return result
end

-- If all else fails, return empty table
return {}

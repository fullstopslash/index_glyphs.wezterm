-- WezTerm Plugin Entry Point
-- This file is required by WezTerm when loading the plugin from GitHub

-- Get the directory where this init.lua file is located
local plugin_dir = debug.getinfo(1, "S").source:match("@?(.*/)")

-- Add plugin directory to package.path
if plugin_dir then
	package.path = package.path .. ';' .. plugin_dir .. '?.lua;' .. plugin_dir .. '?.wez.lua'
end

-- Load the plugin file
local index_glyphs
if plugin_dir then
	local ok, result = pcall(dofile, plugin_dir .. 'index_glyphs.wez.lua')
	if ok and result then
		index_glyphs = result
	else
		-- Fallback: try require
		local ok2, result2 = pcall(require, 'index_glyphs')
		if ok2 and result2 then
			index_glyphs = result2
		end
	end
end

-- Fallback if loading failed
if not index_glyphs then
	-- Try require as last resort
	local ok, result = pcall(require, 'index_glyphs')
	if ok and result then
		index_glyphs = result
	end
end

return index_glyphs or {}

local wezterm = require("wezterm")

local M = {}

local DEFAULT_INDEX_GLYPHS = {
	"󰬺", "󰬻", "󰬼", "󰬽", "󰬾",
	"󰬿", "󰭀", "󰭁", "󰭂", "󰿩",
}

local index_glyphs = DEFAULT_INDEX_GLYPHS
local glyph_count = #DEFAULT_INDEX_GLYPHS

function M.get_index_glyph(tab_index)
	local index = (tab_index or 0) + 1
	if index <= glyph_count then
		return index_glyphs[index]
	end
	-- Wrap around for indices beyond glyph count
	return index_glyphs[((index - 1) % glyph_count) + 1]
end

function M.setup(config, options)
	if options and options.index_glyphs and type(options.index_glyphs) == "table" then
		local count = #options.index_glyphs
		if count > 0 then
			index_glyphs = options.index_glyphs
			glyph_count = count
		end
	end
	
	return config
end

return M

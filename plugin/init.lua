local wezterm = require("wezterm")

local M = {}

local DEFAULT_INDEX_GLYPHS = {
	"󰬺", "󰬻", "󰬼", "󰬽", "󰬾",
	"󰬿", "󰭀", "󰭁", "󰭂", "󰿩",
}

local index_glyphs = DEFAULT_INDEX_GLYPHS

function M.get_index_glyph(tab_index)
	if not tab_index and tab_index ~= 0 then
		tab_index = 0
	end
	
	local index = tab_index + 1
	
	if index > 0 and index <= #index_glyphs then
		return index_glyphs[index]
	end
	
	local wrapped_index = ((index - 1) % #index_glyphs) + 1
	if index_glyphs[wrapped_index] then
		return index_glyphs[wrapped_index]
	end
	
	return wezterm.nerdfonts and wezterm.nerdfonts.dev_terminal or "?"
end

function M.setup(config, options)
	options = options or {}
	
	if options.index_glyphs and type(options.index_glyphs) == "table" and #options.index_glyphs > 0 then
		index_glyphs = options.index_glyphs
	end
	
	return config
end

return M

-- index_glyphs.wez.lua
-- WezTerm Plugin: Index Glyphs for Tab Numbering
-- 
-- Provides customizable index glyphs for tab numbering in WezTerm.
-- This plugin allows you to use custom Unicode glyphs instead of numeric
-- indices for tabs, making them more visually distinct.
--
-- Installation:
--   Place this file in your WezTerm config directory (usually ~/.config/wezterm/)
--
-- Usage:
--   In your wezterm.lua:
--     local index_glyphs = require('index_glyphs')
--     config = index_glyphs.setup(config, {
--       index_glyphs = { "󰬺", "󰬻", "󰬼", ... }  -- Optional: custom glyphs
--     })
--     
--     -- In format-tab-title callback:
--     local glyph = index_glyphs.get_index_glyph(tab.tab_index)
--
-- API:
--   setup(config, options) -> config
--     - config: WezTerm config object
--     - options.index_glyphs: Optional table of glyph strings (defaults provided)
--     - Returns: config object
--
--   get_index_glyph(tab_index) -> string
--     - tab_index: Zero-based tab index (0, 1, 2, ...)
--     - Returns: Glyph string for that tab index (wraps around if > 9)
--
--   get_tab_bar_ui_colors() -> table
--     - Returns: Table with color hints (for backward compatibility)

local wezterm = require("wezterm")

local M = {}

-- Default index glyphs (0-9, then wraps)
local DEFAULT_INDEX_GLYPHS = {
	"󰬺", "󰬻", "󰬼", "󰬽", "󰬾",  -- 0-4
	"󰬿", "󰭀", "󰭁", "󰭂", "󰿩",  -- 5-9
}

-- Plugin state
local index_glyphs = DEFAULT_INDEX_GLYPHS
local config_ref = nil

-- Get index glyph for a tab
-- @param tab_index: Zero-based tab index (0 = first tab, 1 = second tab, etc.)
-- @return: Glyph string for the tab (wraps around if index exceeds available glyphs)
function M.get_index_glyph(tab_index)
	if not tab_index and tab_index ~= 0 then
		tab_index = 0
	end
	
	local index = tab_index + 1  -- Convert to 1-based index for array access
	
	-- Direct lookup if within range
	if index > 0 and index <= #index_glyphs then
		return index_glyphs[index]
	end
	
	-- Wrap around using modulo for indices beyond available glyphs
	local wrapped_index = ((index - 1) % #index_glyphs) + 1
	if index_glyphs[wrapped_index] then
		return index_glyphs[wrapped_index]
	end
	
	-- Ultimate fallback (should never reach here if DEFAULT_INDEX_GLYPHS is valid)
	return wezterm.nerdfonts and wezterm.nerdfonts.dev_terminal or "?"
end

-- Get tab bar UI colors (for backward compatibility)
-- This function is kept for compatibility but colors are now handled by nerd_icons plugin
-- @return: Table with color hints (may be empty)
function M.get_tab_bar_ui_colors()
	local colors = {
		index_active = nil,
		index_inactive = nil,
		icon_color = nil,
	}
	
	-- Try to get from config if available
	if config_ref and config_ref.colors and config_ref.colors.foreground then
		colors.index_inactive = config_ref.colors.foreground
	end
	
	return colors
end

-- Plugin setup: Configures the plugin with options
-- @param config: WezTerm config object
-- @param options: Optional configuration table
--   - options.index_glyphs: Table of glyph strings to use (must be non-empty)
-- @return: config object (for chaining)
function M.setup(config, options)
	options = options or {}
	config_ref = config
	
	-- Validate and use custom glyphs if provided
	if options.index_glyphs and type(options.index_glyphs) == "table" and #options.index_glyphs > 0 then
		index_glyphs = options.index_glyphs
	end
	
	return config
end

return M


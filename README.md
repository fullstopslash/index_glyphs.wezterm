# index_glyphs.wezterm

A WezTerm plugin that provides customizable index glyphs for tab numbering, making tabs more visually distinct with Unicode glyphs instead of numeric indices.

## Features

- 🎨 Customizable Unicode glyphs for tab indices
- 🔄 Automatic wrapping for indices beyond available glyphs
- 📦 Standalone and distributable
- 🔌 Simple plugin API
- 🛡️ Safe error handling with fallbacks

## Installation

### Manual Installation

1. Place `index_glyphs.wez.lua` in your WezTerm config directory:
   ```bash
   cp index_glyphs.wez.lua ~/.config/wezterm/
   ```

2. Load the plugin in your `wezterm.lua`:
   ```lua
   local index_glyphs = require('index_glyphs')
   config = index_glyphs.setup(config)
   ```

## Usage

### Basic Usage

```lua
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Load plugin
local index_glyphs = require('index_glyphs')
config = index_glyphs.setup(config)

-- In your format-tab-title callback:
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local glyph = index_glyphs.get_index_glyph(tab.tab_index)
    return {
        { Text = glyph },
        { Text = " " },
        { Text = tab.active_pane.title },
    }
end)

return config
```

### Custom Glyphs

```lua
config = index_glyphs.setup(config, {
    index_glyphs = {
        "󰬺", "󰬻", "󰬼", "󰬽", "󰬾",  -- 0-4
        "󰬿", "󰭀", "󰭁", "󰭂", "󰿩",  -- 5-9
        -- Add more glyphs as needed
    }
})
```

## API

### `setup(config, options)`

Configures the plugin with optional custom glyphs.

**Parameters:**
- `config`: WezTerm config object
- `options`: Optional configuration table
  - `options.index_glyphs`: Table of glyph strings to use (defaults provided)

**Returns:** `config` object (for chaining)

### `get_index_glyph(tab_index)`

Gets the glyph for a specific tab index.

**Parameters:**
- `tab_index`: Zero-based tab index (0 = first tab, 1 = second tab, etc.)

**Returns:** Glyph string for that tab index (wraps around if index exceeds available glyphs)

**Example:**
```lua
local glyph = index_glyphs.get_index_glyph(0)  -- First tab
local glyph = index_glyphs.get_index_glyph(5)  -- Sixth tab
local glyph = index_glyphs.get_index_glyph(15) -- Wraps around to glyph[5]
```

### `get_tab_bar_ui_colors()`

Returns tab bar UI colors (kept for backward compatibility).

**Returns:** Table with color hints (may be empty)

## Default Glyphs

The plugin comes with 10 default glyphs (indices 0-9):
- 0: 󰬺
- 1: 󰬻
- 2: 󰬼
- 3: 󰬽
- 4: 󰬾
- 5: 󰬿
- 6: 󰭀
- 7: 󰭁
- 8: 󰭂
- 9: 󰿩

For tabs beyond index 9, the glyphs wrap around (e.g., tab 10 uses glyph 0, tab 11 uses glyph 1, etc.).

## Requirements

- WezTerm (with Nerd Font support for default glyphs)
- A Nerd Font installed (recommended for best glyph support)

## License

MIT License - feel free to use and modify as needed.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.


# index_glyphs.wezterm

A WezTerm plugin that provides Unicode glyphs for tab indices.

## Installation

Add to your `wezterm.lua`:

```lua
local wezterm = require("wezterm")
local config = wezterm.config_builder()

local index_glyphs = wezterm.plugin.require('https://github.com/fullstopslash/index_glyphs.wezterm')
index_glyphs.setup(config)

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

## Customization

Customize glyphs by passing options to `setup()`:

```lua
index_glyphs.setup(config, {
    index_glyphs = {
        "󰬺", "󰬻", "󰬼", "󰬽", "󰬾",  -- 0-4
        "󰬿", "󰭀", "󰭁", "󰭂", "󰿩",  -- 5-9
    }
})
```

## License

MIT License

# Installing Railscasts

Railscasts supports Neovim 0.9.5 or later. Install the theme through one of the
methods below, then load it with `:colorscheme railscasts`.

## Neovim plugin managers

### Native packages

Clone the repository into a Neovim `pack/*/start` directory.

**Linux and macOS**

```sh
git clone https://github.com/lukelex/railscasts.nvim.git \
  ~/.local/share/nvim/site/pack/plugins/start/railscasts.nvim
```

**Windows PowerShell**

```powershell
git clone https://github.com/lukelex/railscasts.nvim.git `
  "$env:LOCALAPPDATA\nvim-data\site\pack\plugins\start\railscasts.nvim"
```

### lazy.nvim

```lua
{
  "lukelex/railscasts.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "railscasts"
  end,
},
```

### vim-plug

```vim
Plug "lukelex/railscasts.nvim"
```

## Activate the colorscheme

**Lua**

```lua
vim.cmd.colorscheme "railscasts"
```

**Vimscript**

```vim
colorscheme railscasts
```

## Options

Configure Railscasts before loading the colorscheme.

```lua
require("railscasts").setup {
  high_contrast = true, -- Brighter accents and darker secondary surfaces.
  transparent = false,  -- Let the terminal or Neovim UI provide the background.
  darker_background = false, -- Use the darker #1F1F1F Railscasts surface.
  dim_inactive = false, -- Mute inactive windows and their winbars.
}

vim.cmd.colorscheme "railscasts"
```

The setup API is the only supported configuration interface.

## Health check

Run `:checkhealth railscasts` to verify the supported Neovim version,
`termguicolors`, Railscasts options, and the applied ANSI terminal palette.

## Integrations

### Neovim terminal

Loading Railscasts sets Neovim's `terminal_color_0` through
`terminal_color_15` values using the ANSI mapping in the
[design language](../DESIGN.md#terminal-language). Embedded `:terminal`
buffers therefore match the Kitty, WezTerm, and Alacritty profiles.

### Lualine

```lua
require("lualine").setup {
  options = {
    theme = "railscasts",
  },
}
```

### IndentBlankLine / ibl

No configuration is required. Railscasts defines highlights for both the legacy
IndentBlankLine groups and ibl v3 groups.

### UI plugins

No configuration is required for the supported UI plugins. Railscasts provides
semantic highlights for Snacks, mini.nvim, Trouble, nvim-notify, bufferline,
nvim-dap-ui, Diffview, vim-fugitive, dressing.nvim, nvim-navic, dropbar,
treesitter-context, rainbow-delimiters, aerial.nvim, outline.nvim, neogit,
neotest, and fzf-lua.

### Kitty

Download [`extras/kitty.conf`](../extras/kitty.conf) as a separate include file
to avoid duplicate settings during updates.

**Linux**

```sh
curl -fLo ~/.config/kitty/railscasts.conf \
  https://raw.githubusercontent.com/lukelex/railscasts.nvim/main/extras/kitty.conf
```

Add this line to `~/.config/kitty/kitty.conf`:

```conf
include railscasts.conf
```

### WezTerm

Copy [`extras/wezterm.lua`](../extras/wezterm.lua) into your configuration and
assign it to the `colors` field:

```lua
config.colors = dofile(os.getenv("HOME") .. "/.config/wezterm/railscasts.lua")
```

### Alacritty

Copy [`extras/alacritty.toml`](../extras/alacritty.toml) into your Alacritty
configuration directory, then import it from `alacritty.toml`:

```toml
import = ["~/.config/alacritty/railscasts.toml"]
```

**macOS**

Use `~/Library/Preferences/kitty/kitty.conf` as the main config location.

**Windows**

Save the file beside `%APPDATA%\kitty\kitty.conf` and add:

```conf
include railscasts.conf
```

## Verification

After loading the colorscheme, use `:highlight Normal` to confirm that the
background is `#2B2B2B`. The [design language](../DESIGN.md) documents the
shared palette for external integrations.

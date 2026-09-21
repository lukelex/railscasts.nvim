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

Set options before loading the colorscheme.

```lua
-- Brighter accents and a darker secondary surface.
vim.g.railscasts_high_contrast = true
vim.cmd.colorscheme "railscasts"
```

## Integrations

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

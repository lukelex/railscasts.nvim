# Railscasts Theme for [Neovim](https://neovim.io/)

(this is a work in progress)

The goal is to be a 1/1 port of the original Textmate theme,
respecting the differences and shortcomings of using TreeSitter's
grammar over TextMate's.

The original theme can be found below:

* TextMate: [ryanb/textmate_theme.zip](http://media.railscasts.com/resources/textmate_theme.zip)
* Vim: [ryanb/railscasts.vim](https://github.com/ryanb/dotfiles/blob/997d6caa218d41cdc23e8dda3953d2fd93af2740/vim/colors/railscasts.vim)
* Font: [Bitstream Vera Sans Mono](https://www.fontmirror.com/bitstream-vera-sans-mono)

![railscasts/ruby.png](./screenshots/ruby.png)
![railscasts/telescope.png](./screenshots/telescope.png)

## Language support

Although you can run this color scheme with any language, the only
ones that it has been visually optimized for so far are:

* Ruby
* Lua
* Bash
* YAML

## Installation

Requires Neovim 0.9.5 or later.

### Native packages

```sh
git clone https://github.com/lukelex/railscasts.nvim.git \
  ~/.local/share/nvim/site/pack/plugins/start/railscasts.nvim
```

### Lazy.nvim

```lua
{
  "lukelex/railscasts.nvim",
},
```

### Plug

```vim
Plug "lukelex/railscasts.nvim"
```

## Usage

```lua
-- Lua
vim.cmd.colorscheme "railscasts"
```

```vim
" Vimscript
colorscheme railscasts
```

### Options

Set options before loading the colorscheme.

```lua
-- Use brighter accents and a darker statusline background.
vim.g.railscasts_high_contrast = true
vim.cmd.colorscheme "railscasts"
```

## Local CI

Run the same Lua syntax and Neovim version-matrix checks used in CI:

```sh
docker build --tag railscasts-ci .
docker run --rm railscasts-ci
```

To test the current working tree without rebuilding the image, mount it over
the image workspace:

```sh
docker run --rm --volume "$PWD:/workspace" railscasts-ci
```

### Plugins

#### [Lualine](https://github.com/nvim-lualine/lualine.nvim)

```lua
require("lualine").setup {
  options = {
    -- ... your lualine config
    theme = "railscasts"
    -- ... your lualine config
  }
}
```

#### [IndentBlankLine](https://github.com/lukas-reineke/indent-blankline.nvim)

It just works :wink:.

### External Applications

#### Kitty

Download the theme file, then add `include railscasts.conf` to your Kitty
config file (usually `~/.config/kitty/kitty.conf`). This avoids duplicate
settings when updating the theme.

```sh
curl -fLo ~/.config/kitty/railscasts.conf \
  https://raw.githubusercontent.com/lukelex/railscasts.nvim/main/extras/kitty.conf
```

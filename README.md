# Railscasts Theme for [Neovim](https://neovim.io/)

(this is a work in progress)

The goal is to be a 1/1 port of the original Textmate theme,
respecting the differences and shortcomings of using TreeSitter's
grammar over TextMate's.

The original theme can be found below:

* TextMate: [ryanb/textmate_theme.zip](http://media.railscasts.com/resources/textmate_theme.zip)
* Vim: [ryanb/railscasts.vim](https://github.com/ryanb/dotfiles/blob/master/vim/colors/railscasts.vim)
* Font: [Bitstream Vera Sans Mono](https://www.fontmirror.com/bitstream-vera-sans-mono)

## Language support

Although you can run this color scheme with any language, the only
ones that it has been visually optimized for so far are:

* Ruby
* Lua

## Installation

### Packer

```lua
use({
  "lukelex/railscasts.nvim",
  requires = { "rktjmp/lush.nvim" }
})
```

### LazyVim

I don't use it ¯\\\_(ツ)\_/¯...PRs are welcomed!

## Usage

```lua
vim.cmd.colorscheme "railscasts"
```

### External Plugins

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

#### Kitty

Paste the contents of `./extras/kitty.conf` into your Kitty
config file. Usually found at `~/.config/kitty/kitty.conf`.

```sh
$ wget -O - https://raw.githubusercontent.com/lukelex/railscasts.nvim/main/extras/kitty.conf >> ~/.config/kitty/kitty.conf
```

#### [IndentBlankLine](https://github.com/lukas-reineke/indent-blankline.nvim)

It just works :wink:.

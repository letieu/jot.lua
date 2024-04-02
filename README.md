# jot.lua
![Screenshot 2024-03-26 at 4 23 29 PM](https://github.com/letieu/jot.lua/assets/53562817/48ead8c9-528f-456e-b972-42a6da1737fe)

The plugin help you have a note per project open in a window. When you have
anything to jot down, just open the window and write it down. The note will be
persisted.

**Features:**

* Jot per project in a `markdown` file.
* Customizable jot window (Only for neovim 0.10+)

## Installation

* With **lazy.nvim**
```lua
{
  "letieu/jot.lua",
  dependencies = { "nvim-lua/plenary.nvim" }
}
```
* With **packer.nvim**
```lua
use {
  'letieu/jot.lua',
  requires = {{'nvim-lua/plenary.nvim'}}
}
```

## Usage

*Open*
```lua
require('jot').open()
```

*Close* use `quit_key` in config

*Toggle*
```lua
require('jot').toggle()
```

Map open to a key
```lua
vim.keymap.set("n", "<leader>fj", function() require("jot").open() end, { noremap = true, silent = true })
```

## Config

Default config

```lua
{
  quit_key = "q",
  notes_dir = vim.fn.stdpath("data") .. "/jot",
  win_opts = {
    split = "right",
    focusable = false,
  },
}
```

Customize config to open in floating window (Only for neovim 0.10+)
```lua

{
  quit_key = "q",
  notes_dir = vim.fn.stdpath("data") .. "/jot",
  win_opts = {
    relative = "editor",
    width = 100,
    height = 30,
    row = 5,
    col = 35,
  },
}
```

## Q&A
- What differentiates `jot.lua` from `flote.nvim`?
  - `flote.nvim` open in a floating window, I want to open in a split window.
  - `jot.lua` can customize the window options. Can use floating window if you want.
  - `jot.lua` use `plenary.nvim` to handle file operations.
  - `jot.lua` no need `setup` call

## Inspiration and Thanks
- [Flote.nvim](https://github.com/JellyApple102/flote.nvim) by @JellyApple102

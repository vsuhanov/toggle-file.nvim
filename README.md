# Toggle file
this neovim plugin allows to siply toggle a file in a right split, if the file is already open in another window it will focus it instead. If a window with the file is the current window it will be closed instead (if it's not the only window.)


## Usage
add following keymap
```
local toggle_file = require("toggle-file")
vim.keymap.set("n", "<leader>1", function() toggle_file.toggle_file_window("~/Daily Notes.md") end, opts)
```


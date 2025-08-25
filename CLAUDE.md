# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a simple Neovim plugin called `toggle-file` that allows toggling a specific file in a right split window. The plugin focuses or closes the window if the file is already open.

## Architecture

- `lua/toggle-file/init.lua` - Main plugin logic with the `toggle_file_window()` function
- `plugin/toggle-file.lua` - Plugin entry point (currently empty)
- Standard Neovim plugin structure following Lua-based plugin conventions

## Core Functionality

The main function `toggle_file_window(filename)` in `lua/toggle-file/init.lua:2` implements the toggling logic:
1. If current buffer matches the target file and multiple windows exist, closes the current window
2. If the file is open in another window, focuses that window
3. If not found, opens the file in a right vertical split

## Development Notes

- No build system, linting, or testing framework is currently configured
- Plugin follows standard Neovim Lua plugin patterns
- File operations use Neovim's built-in functions (`vim.fn`, `vim.api`)
- Current TODO: Auto-save files on window leave (see TODO.md:2)

## Usage Pattern

Users set up keymaps like:
```lua
local toggle_file = require("toggle-file")
vim.keymap.set("n", "<leader>1", function() toggle_file.toggle_file_window("~/Daily Notes.md") end)
```
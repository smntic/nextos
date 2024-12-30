{ config, ... }:

{
  config.lua = [
    ''
      local options = {
        -- File encoding
        fileencoding = 'utf-8',
    
        -- Don't write backup files (we have undotree for a reason)
        backup = false,
        writebackup = false,
    
        -- Persistent undos
        undofile = true,
    
        -- Clipboard
        clipboard = "unnamedplus",
    
        -- Friendship ended with tabs. Now spaces are my best friend.
        expandtab = true,
        shiftwidth = 4,
        tabstop = 4,
    
        -- How often certain things update (ms)
        updatetime = 50,
    
        -- Time to wait for a mapped sequence to complete (ms)
        timeoutlen = 500,
    
        -- Case-insensitive search
        ignorecase = true,
        smartcase = true,
    
        -- Searching
        incsearch = true,
    
        -- Column
        colorcolumn = "80",
    
        -- Highlight the current line
        cursorline = true,
    
        -- Number and sign column on the left
        number = true,
        relativenumber = true,
        numberwidth = 4,
        signcolumn = 'yes',
    
        -- Wrapping (not nice)
        wrap = false,
    
        -- How many columns beside the cursor vertically in view
        scrolloff = 8,
    
        -- How many columns beside the cursor horizontally in view
        sidescrolloff = 8,
    
        -- Enable 24-bit RGB colours in the TUI
        termguicolors = true,
      }
    
      local global = {
        -- Set leader to space
        mapleader = ' ',
    
        -- Disable startup message
        startup_message = false,
      }
    
      -- Disable welcome message
      vim.opt.shortmess:append("I")
    
      for name, value in pairs(options) do
        vim.opt[name] = value
      end
    
      for name, value in pairs(global) do
        vim.g[name] = value
      end
    ''
  ];
}

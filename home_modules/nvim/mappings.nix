{ ... }:

{
  config.homeModules.nvim.lua = [
    ''
      -- Yank/Delete all text
      vim.keymap.set('n', '<leader>d%', '<cmd>%d<cr>', { desc = 'General | Delete all text', silent = true })
      vim.keymap.set('n', '<leader>y%', '<cmd>%y+<cr>', { desc = 'General | Yank all text', silent = true })

      -- Inverse tab
      vim.keymap.set('i', '<S-Tab>', '<C-d>', { desc = 'General | Inverse tab', silent = true })

      -- Move text down in visual mode
      vim.keymap.set('v', 'J', function()
        local count = vim.v.count == 0 and 1 or vim.v.count
        return ":m '>+" .. count .. "<CR>gv=gv"
      end, { desc = 'General | Move the selected text down', silent = true, expr = true } );

      -- Move text up in visual mode
      vim.keymap.set('v', 'K', function()
        local count = (vim.v.count == 0 and 1 or vim.v.count) + 1
        return ":m '<-" .. count .. "<CR>gv=gv"
      end, { desc = 'General | Move the selected text up', silent = true, expr = true } );

      -- Keep cursor in the same place when using `J`
      vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'General | Better J', silent = true })

      -- Keep cursor at the center when using half-page jumping
      vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'General | Better half-page down', silent = true })
      vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'General | Better half-page up', silent = true })

      -- Keep cursor at the center when navigating search results
      vim.keymap.set('n', 'n', 'nzzzv', { desc = 'General | Better search next', silent = true })
      vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'General | Better search previous', silent = true })

      -- Better paste in visual mode
      vim.keymap.set('v', 'p', '"_dP', { desc = 'General | Better paste', silent = true })

      -- Copy to system clipboard
      vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'General | Yank to system clipboard', silent = true })
      vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'General | Yank to system clipboard', silent = true })

      -- Delete without yanking
      vim.keymap.set('n', '<leader>d', '"_d', { desc = 'General | Delete without yanking', silent = true })
      vim.keymap.set('v', '<leader>d', '"_d', { desc = 'General | Delete without yanking', silent = true })

      -- Indentation
      vim.keymap.set('v', '<', '<gv', { desc = 'General | Indent backward', silent = true })
      vim.keymap.set('v', '>', '>gv', { desc = 'General | Indent forward', silent = true })

      -- Enter insert mode in the terminal
      vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'General | Enter Insert Mode', silent = true })

      -- Messages
      vim.keymap.set('n', '<leader>nm', '<cmd>messages<cr>', { desc = 'Neovim | Messages', silent = true })

      -- Health
      vim.keymap.set('n', '<leader>nh', '<cmd>checkhealth<cr>', { desc = 'Neovim | Health', silent = true })

      -- Append/insert should match indentation level
      local function match_line(action)
        local line = vim.fn.getline('.')
        if #line == 0 or line:match('^%s+$') then
          return 'cc' -- emtpy line: change line (this matches the indentation level)
        else
          return action -- not empty: proceed as normal
        end
      end

      -- Improved insert
      vim.keymap.set('n', 'i', function()
        return match_line('i')
      end, { desc = 'General | Improved insert', silent = true, expr = true })

      -- Improved append
      vim.keymap.set('n', 'a', function()
        return match_line('a')
      end, { desc = 'General | Improved append', silent = true, expr = true })

      -- Quickfix navigation
      vim.keymap.set('n', '<leader>k', '<cmd>cnext<CR>zz', { desc = 'General | Quickfix next', silent = true })
      vim.keymap.set('n', '<leader>j', '<cmd>cprev<CR>zz', { desc = 'General | Quickfix prev', silent = true })
      vim.keymap.set('n', '<leader>K', '<cmd>lnext<CR>zz', { desc = 'General | Quickfix next in location list', silent = true })
      vim.keymap.set('n', '<leader>J', '<cmd>lprev<CR>zz', { desc = 'General | Quickfix prev in location list', silent = true })

      -- netrw (open to top)
      vim.keymap.set('n', '<leader>nF', '<cmd>Ex<CR>', { desc = 'Neovim | Open netrw to top', silent = true })

      -- netrw (open with cursor on current file)
      -- credits to: https://www.reddit.com/r/neovim/comments/14e59ub/i_wrote_a_function_that_moves_the_cursor_to_the/
      vim.keymap.set('n', '<leader>nf',
        function()
          local cur_file = vim.fn.expand('%:t')
          vim.cmd.Ex()
          print(cur_file)

          local starting_line = 8 -- line number of the first file
          local lines = vim.api.nvim_buf_get_lines(0, starting_line, -1, false)
          print(lines)
          for i, file in ipairs(lines) do
            -- 1 is the start index, true disables special pattern matching characters
            if file:find(cur_file, 1, true) then
              vim.api.nvim_win_set_cursor(0, { starting_line + i, 0 })
              return
            end
          end
        end
      , { desc = 'Neovim | Open netrw to current file', silent = true })

      -- Toggle terminal
      vim.keymap.set('n', '<leader>nt', '<cmd>ToggleTerm<CR>', { desc = 'General | Toggle Terminal', silent = true })

      -- Mark
      vim.keymap.set('n', '<leader>m', '`', { desc = 'General | Marks Shortcut', silent = true })
    ''
  ];
}

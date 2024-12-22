{ pkgs, ... }:

let
  options = ''
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
      smartindent = true,
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
      hlsearch = false,
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

      -- How many columns in the buffer before horizontal scrolling is enabled
      scrolloff = 8,

      -- How many columns on the right of the cursor
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
  '';
  mappings = ''
    -- Yank/Delete all text
    vim.keymap.set('n', '<leader>D', '<cmd>%d<cr>', { desc = 'General | Delete all text', silent = true })
    vim.keymap.set('n', '<leader>y', '<cmd>%y+<cr>', { desc = 'General | Yank all text', silent = true })

    -- Inverse tab
    vim.keymap.set('i', '<S-Tab>', '<C-d>', { desc = 'General | Inverse tab', silent = true })

    -- Move text in visual mode
    vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'General | Move the selected text down', silent = true })
    vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'General | Move the selected text up', silent = true })

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
    vim.keymap.set('n', '<leader>K', '<cmd>lnext<CR>zz', { desc = 'General | Quickfix next in window', silent = true })
    vim.keymap.set('n', '<leader>J', '<cmd>lprev<CR>zz', { desc = 'General | Quickfix prev in window', silent = true })

    -- netrw
    vim.keymap.set('n', '<leader>nf', '<cmd>Ex<CR>', { desc = 'Neovim | Open netrw', silent = true })
  '';
  make = ''
    -- This could technically be it's own plugin

    local function term_exec(cmd)
      if vim.env.TMUX ~= nil then
        local tmux_cmd = string.format('tmux send-keys -t 1 "%s" C-m', cmd)
        vim.fn.system(tmux_cmd)
      else
        local term_cmd = string.format('TermExec direction=horizontal cmd="%s" go_back=0', cmd)
        vim.cmd(term_cmd)
      end
    end
    
    local build_functions = {
      cpp = function()
        local filename = vim.fn.expand('%:p')
        local output_filename = vim.fn.expand('%:p:r')
        local command = string.format(
          'g++ -DLOCAL -include /usr/include/c++/13.2/x86_64-unknown-linux-gnu/bits/stdc++.h -Wall -Wextra "%s" -o "%s"',
          filename,
          output_filename
        )
        vim.api.nvim_command('! ' .. command)
      end,
    }
    
    local run_functions = {
      cpp = function()
        local cmd = vim.fn.expand('%:p:r')
        term_exec(cmd)
      end,
      python = function()
        local filename = vim.fn.expand('%:p')
        local cmd = string.format('python %s', filename)
        term_exec(cmd)
      end,
      javascript = function()
        local filename = vim.fn.expand('%:p')
        local cmd = string.format('node %s', filename)
        term_exec(cmd)
      end,
    }
    
    local function check_script(script)
      local f = io.open(script, 'r')
      if f == nil then
        return false
      end
      io.close(f)
      return true
    end
    
    local function run_from_script(script)
      term_exec(script)
    end
    
    local function build_from_script(script)
      term_exec(script)
    end
    
    local function run_program()
      local shell_script = vim.fn.getcwd() .. '/run.sh'
      if check_script(shell_script) then
        run_from_script(shell_script)
        return
      end
    
      local filetype = vim.bo.filetype
    
      if run_functions[filetype] then
        run_functions[filetype]()
      else
        print("No run function defined for filetype: " .. filetype)
      end
    end
    
    local function build_program()
      local shell_script = vim.fn.getcwd() .. '/build.sh'
      if check_script(shell_script) then
        build_from_script(shell_script)
        return
      end
    
      local filetype = vim.bo.filetype
    
      if build_functions[filetype] then
        build_functions[filetype]()
      else
        print("No build function defined for filetype: " .. filetype)
      end
    end
    
    vim.keymap.set('n', '<leader>b', build_program, { desc = 'Make | Build Program', silent = true })
    vim.keymap.set('n', '<leader>r', run_program, { desc = 'Make | Run Program', silent = true })
  '';
  lsp = ''
    local conform = require('conform')

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        vim.keymap.set('n', '<leader>lk', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'LSP | Hover', buffer = event.buf, silent = true })
        vim.keymap.set('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'LSP | Go to definition', buffer = event.buf, silent = true })
        vim.keymap.set('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'LSP | Go to declration', buffer = event.buf, silent = true }) 
        vim.keymap.set('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'LSP | Go to implementation', buffer = event.buf, silent = true })
        vim.keymap.set('n', '<leader>lo', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'LSP | Go to type definition', buffer = event.buf, silent = true })
        vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'LSP | Show references', buffer = event.buf, silent = true })
        vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'LSP | Signature help', buffer = event.buf, silent = true })
        vim.keymap.set('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'LSP | Rename', buffer = event.buf, silent = true })
        vim.keymap.set({'n', 'x'}, '<leader>lf', conform.format, { desc = 'LSP | Format', buffer = event.buf, silent = true })
        vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'LSP | Code action', buffer = event.buf, silent = true })
      end
    })

    local lspconfig = require('lspconfig')
    local ls_capabilities = require('cmp_nvim_lsp').default_capabilities()
   
    local setup_lsp = function(server)
      lspconfig[server].setup({
        capabilities = lsp_capabilities
      })
    end

    local servers = {
      'clangd',
      'pyright',
      'nil_ls',
    }

    for _, server in ipairs(servers) do
      setup_lsp(server)
    end

    local cmp = require('cmp')
    cmp.setup({
      sources = {
	    { name = 'nvim_lsp' },
	    { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
	    { name = 'luasnip' },
      },

      mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
      }),

      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {
              ignore_cmds = { 'Man', '!' },
          },
        },
      }),
    })

    local formatters = {
      lua = { "stylua" },
      python = { "black" },
      cpp = { "clang_format" },
      c = { "clang_format" },
    }
    
    local prettier_ft = {
      "css",
      "html",
      "json",
      "javascriptreact",
      "javascript",
      "markdown",
      "typescript",
      "typescriptreact",
    }
    
    for _, filetype in pairs(prettier_ft) do
      formatters[filetype] = { "prettier" }
    end
    
    conform.setup ({
      formatters_by_ft = formatters,
    })
  '';
  whichKey = ''
    local which_key = require('which-key')
    which_key.add({
      { '<leader>g', group = 'Git', icon = ' ' },
      { '<leader>f', group = 'Find', icon = '󰈞 ' },
      { '<leader>h', group = 'Harpoon', icon = '󰛢 ' },
      { '<leader>l', group = 'LSP', icon = '󰌵 ' },
      { '<leader>n', group = 'Neovim', icon = ' ' },
    })
  '';
  telescope = ''
    local telescope_builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope | Find files', silent = true })
    vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope | Live grep', silent = true })
    vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope | Buffers', silent = true })
    vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope | Help tags', silent = true })

    local telescope = require('telescope')
    local telescope_actions = require('telescope.actions')
    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-k>'] = telescope_actions.move_selection_previous,
            ['<C-j>'] = telescope_actions.move_selection_next,
          }
        }
      }
    }
  '';
  fugitive = ''
    vim.keymap.set('n', '<leader>gg', '<cmd>Git<CR>', { desc = 'Git | Open window', silent = true })
    vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<CR>', { desc = 'Git | Commit', silent = true })
    vim.keymap.set('n', '<leader>gr', '<cmd>Git rebase -i<CR>', { desc = 'Git | Interactive rebase', silent = true })
    vim.keymap.set('n', '<leader>gd', '<cmd>Git diff<CR>', { desc = 'Git diff', silent = true })
    vim.keymap.set('n', '<leader>gl', '<cmd>Git log<CR>', { desc = 'Git | Log', silent = true })
    vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = 'Git | Blame', silent = true })
  '';
  harpoon = ''
    local harpoon = require('harpoon')
    harpoon:setup()
    vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon | Add', silent = true })
    vim.keymap.set('n', '<leader>hm', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon | Menu', silent = true })

    for i = 1, 9 do
      vim.keymap.set('n', '<A-' .. tostring(i) .. '>', function() harpoon:list():select(11 - i) end, { desc = 'Harpoon | Goto ' .. tostring(i), silent = true })
    end
    vim.keymap.set('n', '<A-0>', function() harpoon:list():select(1) end, { desc = 'Harpoon | Goto 1', silent = true })
  '';
  undotree = ''
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree | Toggle', silent = true })
  '';
  markdown-preview = ''
    vim.keymap.set('n', '<leader>m', vim.cmd.MarkdownPreviewToggle, { desc = 'MarkdownPreview | Toggle', silent = true })
  '';
  toggleterm = ''
    local toggleterm = require('toggleterm')
    toggleterm.setup()
  '';
  blankline = ''
    local blankline = require('ibl')
    blankline.setup()
  '';
  plugins = lsp + whichKey + telescope + fugitive + harpoon + undotree + markdown-preview + toggleterm + blankline;
  luaConfig = options + mappings + make + plugins;
in
  {
    home.packages = [
      pkgs.ripgrep

      # LSP & Formatters
      pkgs.pyright
      pkgs.nil
      pkgs.clang-tools
      pkgs.stylua
      pkgs.black
    ];

    programs.neovim = {
      enable = true;
  
      # Set nvim as the default editor and replace vim
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
  
      # Find the plugin names here: https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/vim-plugin-names
      # As a general rule, when there is invalid punctuation, like a period, replace it with a hyphen.
      # You can also run `nix-env -f '<nixpkgs>' -qaP -A vimPlugins`.
      plugins = with pkgs.vimPlugins; [
        # General
        telescope-nvim
        nvim-treesitter.withAllGrammars
        playground
        harpoon2
       	pkgs.vimPlugins.undotree
       	vim-fugitive
      	which-key-nvim
       	comment-nvim
        indent-blankline-nvim
        toggleterm-nvim

        # LSP
        nvim-lspconfig
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp_luasnip
        cmp-nvim-lsp
        cmp-nvim-lua
        luasnip
        friendly-snippets
        conform-nvim

        # Markdown
        render-markdown-nvim
        markdown-preview-nvim
      ];
  
      extraLuaConfig = luaConfig;
    };
  }

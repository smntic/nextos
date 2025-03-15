{ pkgs, ... }:

{
  config = {
    home.packages = [
      pkgs.clang-tools
      pkgs.elixir-ls
      pkgs.haskell-language-server
      pkgs.nil
      pkgs.pyright
      pkgs.rust-analyzer
      pkgs.typescript-language-server
      pkgs.vscode-langservers-extracted
    ];

    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      luasnip
    ];

    homeModules.nvim.lua = [
      ''
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
          'hls',
          'html',
          'nil_ls',
          'pyright',
          'rust_analyzer',
          'ts_ls',
        }

        for _, server in ipairs(servers) do
          setup_lsp(server)
        end

        lspconfig.elixirls.setup({
          capabilities = lsp_capabilities,
          cmd = { "${pkgs.elixir-ls}/bin/elixir-ls" },
        })
      ''
    ];
  };
}

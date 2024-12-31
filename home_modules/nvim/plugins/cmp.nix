{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-nvim-lsp-signature-help
      friendly-snippets
    ];

    homeModules.nvim.lua = [
      ''
        local cmp = require('cmp')
        cmp.setup({
          sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' },
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
      ''
    ];
  };
}

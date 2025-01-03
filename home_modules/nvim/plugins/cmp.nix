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
          completion = {
            autocomplete = false,
          },

          sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' },
          },

          mapping = cmp.mapping.preset.insert({
            ['<C-k>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                cmp.complete()
              end
            end),
            ['<C-j>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                cmp.complete()
              end
            end),
            ['<Tab>'] = cmp.mapping.confirm({ select = true }),
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

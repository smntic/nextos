{ pkgs, inputs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      inputs.blink.packages.${pkgs.system}.blink-cmp
      luasnip
      friendly-snippets
    ];

    homeModules.nvim.lua = [
      ''
        local blink = require('blink.cmp')
        blink.setup({
          keymap = {
            preset = 'none',

            ['<C-k>'] = { 'show', 'select_prev', 'fallback' },
            ['<C-j>'] = { 'show_and_insert', 'select_next', 'fallback' },
            ['<C-m>'] = { 'accept', 'fallback' },
            ['<Tab>'] = { 'accept', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
            ['<C-l>'] = { 'show_signature', 'fallback' },
          },

          appearance = {
            nerd_font_variant = 'mono'
          },

          completion = {
            list = { selection = { auto_insert = true } },
            trigger = {
              show_on_keyword = false,
              show_on_trigger_character = false,
              show_on_insert_on_trigger_character = false,
              show_on_accept_on_trigger_character = false,
            },
          },

          snippets = {
            preset = 'luasnip',
          },
      
          sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
          },

          signature = {
            enabled = true,

            trigger = {
              show_on_insert = false,
              show_on_keyword = false,
              show_on_trigger_character = false,
              show_on_insert_on_trigger_character = false,
            },

            window = {
              show_documentation = true,
            },
          },
        })

        require('luasnip.loaders.from_vscode').lazy_load()
      ''
    ];
  };
}

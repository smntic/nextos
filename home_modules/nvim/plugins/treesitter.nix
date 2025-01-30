{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-parsers.elixir
      playground
    ];

    homeModules.nvim.lua = [
      ''
        treesitter_configs = require('nvim-treesitter.configs')
        treesitter_configs.setup({
          highlight = {
            enable = true,
            disable = { "latex" },
            additional_vim_regex_highlighting = false,
          },
        })
      ''
    ];
  };
}

{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    indent-blankline-nvim
  ];

  homeModules.nvim.lua = [
    ''
      local blankline = require('ibl')
      blankline.setup()
    ''
  ];
}

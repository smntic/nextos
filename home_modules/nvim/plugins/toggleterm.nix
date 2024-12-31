{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      toggleterm-nvim
    ];

    homeModules.nvim.lua = [
      ''
        local toggleterm = require('toggleterm')
        toggleterm.setup()
      ''
    ];
  };
}

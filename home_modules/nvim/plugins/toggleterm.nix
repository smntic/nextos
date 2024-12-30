{ pkgs, config, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      toggleterm-nvim
    ];

    lua = [
      ''
        local toggleterm = require('toggleterm')
        toggleterm.setup()
      ''
    ];
  };
}


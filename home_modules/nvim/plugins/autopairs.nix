{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-autopairs
    ];

    homeModules.nvim.lua = [ 
      ''
        local autopairs = require('nvim-autopairs')
        autopairs.setup()
      ''
    ];
  };
}

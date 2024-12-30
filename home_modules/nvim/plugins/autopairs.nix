{ pkgs, config, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-autopairs
    ];
  
    lua = [ 
      ''
        local autopairs = require('nvim-autopairs')
        autopairs.setup()
      ''
    ];
  };
}

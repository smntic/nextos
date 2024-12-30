{ pkgs, config, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      comment-nvim
    ];
    
    lua = [
      ''
        local comment = require('Comment')
        comment.setup()
      ''
    ];
  };
}

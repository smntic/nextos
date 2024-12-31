{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      comment-nvim
    ];

    homeModules.nvim.lua = [
      ''
        local comment = require('Comment')
        comment.setup()
      ''
    ];
  };
}

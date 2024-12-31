{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      render-markdown-nvim
    ];

    homeModules.nvim.lua = [
      ''
      ''
    ];
  };
}

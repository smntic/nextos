{ pkgs, config, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      render-markdown-nvim
    ];

    lua = [
      ''
      ''
    ];
  };
}

{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      playground
    ];
  };
}

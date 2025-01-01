{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-parsers.elixir
      playground
    ];
  };
}

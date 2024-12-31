{ lib, config, ... }:

{
  imports = [
    ./nvim/lua_config.nix
  ];

  options = {
    homeModules.nvim.enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf config.homeModules.nvim.enable {
    programs.neovim = {
      enable = true;

      # Set nvim as the default editor and replace vim
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}

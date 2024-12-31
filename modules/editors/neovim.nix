{ pkgs, lib, config, ... }:

{
  options = {
    modules.nvim.enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf config.modules.nvim.enable {
    environment.systemPackages = [ pkgs.neovim ];
  };
}

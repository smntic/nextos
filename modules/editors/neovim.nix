{ pkgs, lib, config, ... }:

{
  options = {
    neovim.enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf config.neovim.enable {
    environment.systemPackages = [ pkgs.neovim ];
  };
}

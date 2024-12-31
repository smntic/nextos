{ pkgs, lib, config, root, ... }:

let
  operator = import "${root}/lib/helpers/operator.nix" { inherit lib; };
in
  {
    options = {
      modules.wine.enable = lib.mkEnableOption "wine";
      modules.wine.waylandSupport = lib.mkEnableOption "wayland support (unstable)";
    };

    config = lib.mkIf config.modules.wine.enable {
      # Based on https://nixos.wiki/wiki/Wine
      environment.systemPackages = operator.ternary config.modules.wine.waylandSupport
        [ pkgs.wineWowPackages.waylandFull ] [ pkgs.wineWowPackages.stable ];
    };
  }

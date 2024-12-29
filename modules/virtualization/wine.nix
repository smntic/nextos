{ pkgs, lib, config, root, ... }:

let
  operator = import "${root}/lib/helpers/operator.nix" { inherit lib; };
in
  {
    options = {
      wine.enable = lib.mkEnableOption "wine";
      wine.waylandSupport = lib.mkEnableOption "wayland support (unstable)";
    };
  
    config = lib.mkIf config.wine.enable {
      # Based on https://nixos.wiki/wiki/Wine
      environment.systemPackages = operator.ternary config.wine.waylandSupport
        [ pkgs.wineWowPackages.waylandFull ] [ pkgs.wineWowPackages.stable ];
    };
  }

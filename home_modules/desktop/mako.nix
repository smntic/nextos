{ pkgs, ... }:

{
  home.packages = [
    pkgs.libnotify
  ];

  services.mako = {
    enable = true;
    defaultTimeout = 3000;
  };
}

{ ... }:

{
  imports = [
    ./waybar/modules.nix
    ./waybar/formats.nix
    ./waybar/style.nix
  ];

  programs.waybar.enable = true;
}

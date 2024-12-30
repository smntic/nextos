{ ... }:

{
  imports = [
    ./rofi/config.nix
    ./rofi/bindings.nix
    ./rofi/theme.nix
  ];

  programs.rofi.enable = true;
}

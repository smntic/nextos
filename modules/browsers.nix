{ lib, ... }:

{
  imports = [
    ./browsers/chromium.nix
    ./browsers/firefox.nix
  ];

  chromium.enable = lib.mkDefault false;
  firefox.enable = lib.mkDefault false;
}

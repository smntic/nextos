{ lib, ... }:

{
  imports = [
    ./audio/bluetooth.nix
    ./audio/pipewire.nix
  ];

  bluetooth.enable = lib.mkDefault true;
}


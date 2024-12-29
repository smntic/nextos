{ lib, ... }:

{
  imports = [
    ./editors/neovim.nix
  ];

  neovim.enable = lib.mkDefault true;
}

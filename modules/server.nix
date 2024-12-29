{ lib, ... }:

{
  imports = [
    ./server/ssh.nix
  ];

  ssh.enable = lib.mkDefault true;
}

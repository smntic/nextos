{ ... }:

{
  imports = [
    ./virtualization/docker.nix
    ./virtualization/steam_run.nix
    ./virtualization/qemu.nix
    ./virtualization/wine.nix
  ];
}

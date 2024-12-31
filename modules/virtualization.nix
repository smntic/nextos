{ ... }:

{
  imports = [
    ./virtualization/docker.nix
    ./virtualization/qemu.nix
    ./virtualization/wine.nix
  ];
}

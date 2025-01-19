{ ... }:

{
  imports = [
    ./virtualization/appimage_run.nix
    ./virtualization/docker.nix
    ./virtualization/libvirt.nix
    ./virtualization/qemu.nix
    ./virtualization/steam_run.nix
    ./virtualization/virt_manager.nix
    ./virtualization/wine.nix
  ];
}

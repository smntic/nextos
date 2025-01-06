{ pkgs, lib, config, ... }:

{
  options = {
    modules.libvirt.enable = lib.mkEnableOption "libvirt";
  };

  config = lib.mkIf config.modules.libvirt.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };
  };
}

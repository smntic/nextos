{ lib, config, ... }:

{
  options = {
    modules.pipewire.enable = lib.mkEnableOption "pipewire";
  };

  config = lib.mkIf config.modules.pipewire.enable {
    # https://wiki.nixos.org/wiki/PipeWire
    # Jack support is not necessary
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}

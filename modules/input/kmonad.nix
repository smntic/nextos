{ lib, config, inputs, ... }:

{
  imports = [
    inputs.kmonad.nixosModules.default
  ];

  options = {
    modules.kmonad.enable = lib.mkEnableOption "kmonad";
    modules.kmonad.keyboards = lib.mkOption {
      type = lib.types.attrs;
      description = "kmonad keyboard configuration";
      default = {};
    };
  };

  config = {
    services.kmonad = lib.mkIf config.modules.kmonad.enable {
      enable = true;
      keyboards = config.modules.kmonad.keyboards;
    };
    systemd.services.kmonad.serviceConfig.Restart = "no";
  };
}

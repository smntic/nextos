{ lib, config, ... }:

{
  options = {
    modules.key-repeat.enable = lib.mkEnableOption "key repeat settings";
    modules.key-repeat.delay = lib.mkOption {
      type = lib.types.int;
      description = "The number of milliseconds after a keypress before a key will begin repeating.";
      example = 250;
    };

    modules.key-repeat.interval = lib.mkOption {
      type = lib.types.int;
      description = "The number of milliseconds between repeated keypresses.";
      example = 50;
    };
  };

  config = lib.mkIf config.modules.key-repeat.enable {
    services.xserver = {
      autoRepeatDelay = config.modules.key-repeat.delay;
      autoRepeatInterval = config.modules.key-repeat.interval;
    };
  };
}

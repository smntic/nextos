{ lib, config, root, ... }:

let
  operator = import "${root}/lib/helpers/operator.nix" { inherit lib; };
in
  {
    options = {
      modules.libinput.enable = lib.mkEnableOption "libinput";
      modules.libinput.naturalScrolling = lib.mkEnableOption "natural scrolling";
      modules.libinput.mouseAcceleration = lib.mkEnableOption "mouse acceleration";
    };

    config = lib.mkIf config.modules.libinput.enable {
      services.libinput = {
        touchpad = {
          naturalScrolling = config.modules.libinput.naturalScrolling;
        };

        mouse = {
          accelProfile = operator.ternary config.modules.libinput.mouseAcceleration "adaptive" "flat";
        };
      };
    };
  }

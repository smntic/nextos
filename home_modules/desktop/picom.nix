{ lib, config, ... }:

{
  options = {
    homeModules.picom.enable = lib.mkEnableOption "picom";
  };

  config = lib.mkIf config.homeModules.picom.enable {
    services.picom = {
      enable = true;
      vSync = true;

      settings = {
        backend = "glx";
        
        blur = {
          method = "dual_kawase";
          strength = 3;
        };

        blur-background-exclude = [
          "window_type = 'menu'"
          "window_type = 'dropdown_menu'"
          "window_type = 'popup_menu'"
          "window_type = 'tooltip'"
          "class_g = 'firefox' && window_type = 'utility'" # doesn't work.
          "class_g = 'slop'"
        ];
      };

      # opacityRule = [
      #   "100:class_g = 'Firefox' && window_type = 'utility'"
      #   "100:class_g ?= 'slop'"
      # ];
    };
  };
}

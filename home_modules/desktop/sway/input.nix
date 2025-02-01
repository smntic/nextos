{ ... }:

{
  wayland.windowManager.sway.config.input = {
    "type:touchpad" = {
      dwt = "enabled";
      tap = "enabled";
      middle_emulation = "enabled";
      natural_scroll = "enabled";
      scroll_factor = "0.3";
    };
    
    "type:pointer" = {
      accel_profile = "flat";
    };

    "type:keyboard" = {
      repeat_delay = "300";
      repeat_rate = "30";
    };
  };
}

{ ... }:

{
  wayland.windowManager.sway.config.input = {
    "type:touchpad" = {
      dwt = "enabled";
      tap = "enabled";
      middle_emulation = "enabled";
      natural_scroll = "enabled";
      scroll_factor = "0.6";
    };
    
    "type:pointer" = {
      accel_profile = "flat";
    };

    "type:keyboard" = {
      repeat_delay = "300";
      repeat_rate = "30";
    };

    # "type:tablet" = {
    #   map_to_output = "\"Dell Inc. DELL 2009W KM509834DJ0U\"";
    # };
  };
}

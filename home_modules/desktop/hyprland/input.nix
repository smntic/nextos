{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    gestures = {
      workspace_swipe = true;
    };
    
    input = {
      # Global mouse config
      accel_profile = "flat";
      
      # Global touchpad config
      touchpad = {
        scroll_factor = 0.3;
      };
      
      # Global keyboard config
      kb_layout = "us";
      kb_variant = "";
      #kb_variant = "colemak_dh";
      kb_options = "caps:escape";
      repeat_rate = 30;
      repeat_delay = 300; 
    };

    # Find these devices with `hyprctl devices`
    device = [
      {
        name = "elan06c2:00-04f3:3195-touchpad";
        accel_profile = "adaptive";
        natural_scroll = true;
      }
    ];
  };
}

{ ... }:

{
  wayland.windowManager.sway.config = {
    window = {
      border = 1;
      titlebar = false;
    };

    gaps = {
      inner = 2;
      outer = 1;
    };
  };
}

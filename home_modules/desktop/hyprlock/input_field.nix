{ lib, config, ... }:

{
  programs.hyprlock.settings.input-field = lib.mkForce [
    {
      size = "200, 50";
      position = "0, 0";

      fade_on_empty = false;

      dots_center = true;
      dots_fade_time = 0;
      rounding = 10;
      outline_thickness = 1;

      placeholder_text = "Enter password...";
      fail_text = "Incorrect";

      check_color = "rgb(${config.lib.stylix.colors.base0A})";
      fail_color =  "rgb(${config.lib.stylix.colors.base08})";
      font_color =  "rgb(${config.lib.stylix.colors.base05})";
      inner_color = "rgb(${config.lib.stylix.colors.base00})";
      outer_color = "rgb(${config.lib.stylix.colors.base03})";
    }
  ];
}

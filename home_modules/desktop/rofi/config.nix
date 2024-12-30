{ ... }:

{
  programs.rofi.extraConfig = {
    modi = "drun,run";
    show-icons = true;
    fuzzy = true;
    terminal = "kitty";
  };
}

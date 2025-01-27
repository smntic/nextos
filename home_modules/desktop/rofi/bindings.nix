{ ... }:

{
  programs.rofi.extraConfig = {
    # Based on https://www.reddit.com/r/qtools/comments/kaiaa8/comment/i4ifgyf
    kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
    kb-row-down = "Down,Control+j";
    kb-accept-entry = "Control+m,Return,KP_Enter";
    kb-remove-to-eol = "Control+Shift+e";
    kb-mode-next = "Shift+Right,Control+Tab,Control+l";
    kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
    kb-remove-char-back = "BackSpace";
    kb-cancel = "Escape,Control+c";
    kb-mode-complete = ""; # Otherwise bound to Control+l
    kb-secondary-copy = ""; # Otherwise bound to Control+c
  };
}

# My apologies for the monolithic config file; the lock script is used for both bindings and startup.
{ lib, pkgs, config, ... }:

{
  home.packages = lib.mkIf config.homeModules.i3.enable [
    pkgs.feh
    pkgs.xss-lock
    pkgs.haskellPackages.greenclip
    pkgs.i3lock-color
  ];

  xsession.windowManager.i3 = let
    mod = "Mod4";
    ctrl = "Control";
    print = "Print";
    alt = "Mod1";
    shift = "Shift";

    refreshStatus = "killall -SIGUSR1 i3status";

    lockScript = pkgs.pkgs.writeShellScript "lock" ''
      ${pkgs.i3lock-color}/bin/i3lock --nofork                    \
        --insidever-color=#${config.lib.stylix.colors.base00}80   \
        --ringver-color=#${config.lib.stylix.colors.base0D}       \
                                                                  \
        --insidewrong-color=#${config.lib.stylix.colors.base00}80 \
        --ringwrong-color=#${config.lib.stylix.colors.base08}     \
                                                                  \
        --inside-color=#${config.lib.stylix.colors.base00}80      \
        --ring-color=#${config.lib.stylix.colors.base0B}          \
        --line-color=#${config.lib.stylix.colors.base00}          \
        --separator-color=#${config.lib.stylix.colors.base00}     \
                                                                  \
        --verif-color=#${config.lib.stylix.colors.base05}	      \
        --wrong-color=#${config.lib.stylix.colors.base05}         \
        --time-color=#${config.lib.stylix.colors.base05}          \
        --date-color=#${config.lib.stylix.colors.base05}          \
        --layout-color=#${config.lib.stylix.colors.base05}        \
        --layout-color=#${config.lib.stylix.colors.base05}        \
        --modif-color=#${config.lib.stylix.colors.base05}         \
        --keyhl-color=#${config.lib.stylix.colors.base0B}         \
        --bshl-color=#${config.lib.stylix.colors.base0E}          \
                                                                  \
        --screen 1                                                \
        --blur 5                                                  \
        --clock                                                   \
        --color=#${config.lib.stylix.colors.base00}               \
    '';
  in
    {
      enable = true;
      config = {
        startup = [
          { command = "--no-startup-id picom -b"; always = true; }
          { command = "--no-startup-id redshift"; always = false; }
          { command = "--no-startup-id greenclip daemon"; always = false; }
          { command = "--no-startup-id dunst"; always = false; }
          { command = "--no-startup-id feh --bg-fill ${config.stylix.image}"; always = true; }
          { command = "--no-startup-id xss-lock --transfer-sleep-lock -- ${lockScript}"; always = false; }
        ];

        keybindings = {
          # Audio control
          "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1 && ${refreshStatus}";
          "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ${refreshStatus}";
          "XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ${refreshStatus}";

          # Brightness control
          "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl s 10%+";
          "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl s 10%-";

          # Start a terminal
          "${mod}+Return" = "exec --no-startup-id kitty";

          # Open firefox
          "${mod}+w" = "exec --no-startup-id firefox";

          # Kill focused window
          "${mod}+${shift}+q" = "kill";

          # Start dmenu (a program launcher)
          "${mod}+d" = "exec --no-startup-id rofi -show drun";

          # Take a screenshot
          "${mod}+${print}" = "exec --no-startup-id maim -slB --color=1,1,1,0.4 --bordersize=1 | xclip -selection clipboard -t image/png";

          # Emoji keyboard
          "${mod}+period" = "exec --no-startup-id rofimoji --max-recent 0";

          # Lock screen
          "${ctrl}+${alt}+l" = "exec --no-startup-id ${lockScript}";

          # Change focus
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          # Move focused window
          "${mod}+${shift}+h" = "move left 100px";
          "${mod}+${shift}+j" = "move down 100px";
          "${mod}+${shift}+k" = "move up 100px";
          "${mod}+${shift}+l" = "move right 100px";

          # Split in horizontal orientation
          "${mod}+b" = "split h";

          # Split in vertical orientation
          "${mod}+v" = "split v";

          # Enter fullscreen mode for the focused container
          "${mod}+f" = "fullscreen toggle";

          # Toggle tiling / floating
          "${mod}+${shift}+space" = "floating toggle";

          # Change focus between tiling / floating windows
          "${mod}+space" = "focus mode_toggle";

          # Switch to workspace
          "${mod}+0" = "workspace number \"1\"";
          "${mod}+9" = "workspace number \"2\"";
          "${mod}+8" = "workspace number \"3\"";
          "${mod}+7" = "workspace number \"4\"";
          "${mod}+6" = "workspace number \"5\"";
          "${mod}+5" = "workspace number \"6\"";
          "${mod}+4" = "workspace number \"7\"";
          "${mod}+3" = "workspace number \"8\"";
          "${mod}+2" = "workspace number \"9\"";
          "${mod}+1" = "workspace number \"10\"";

          # Move focused container to workspace
          "${mod}+${shift}+0" = "move container to workspace number \"1\"";
          "${mod}+${shift}+9" = "move container to workspace number \"2\"";
          "${mod}+${shift}+8" = "move container to workspace number \"3\"";
          "${mod}+${shift}+7" = "move container to workspace number \"4\"";
          "${mod}+${shift}+6" = "move container to workspace number \"5\"";
          "${mod}+${shift}+5" = "move container to workspace number \"6\"";
          "${mod}+${shift}+4" = "move container to workspace number \"7\"";
          "${mod}+${shift}+3" = "move container to workspace number \"8\"";
          "${mod}+${shift}+2" = "move container to workspace number \"9\"";
          "${mod}+${shift}+1" = "move container to workspace number \"10\"";

          # Move focused workspace
          "${mod}+${ctrl}+h" = "move workspace to output left";
          "${mod}+${ctrl}+l" = "move workspace to output right";
          "${mod}+${ctrl}+j" = "move workspace to output up";
          "${mod}+${ctrl}+k" = "move workspace to output down";

          # Reload the configuration file
          "${mod}+${shift}+c" = "reload";

          # Restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
          "${mod}+${shift}+r" = "restart";

          # Resize mode
          "${mod}+r" = "mode \"resize\"";

          # Notification selection
          "${mod}+n" = "exec --no-startup-id dunstctl action";

          # Clipboard selection. This is the pinnacle of hackery. Removes last line because static "updated to v4.1!!!!!" message...
          "${mod}+${shift}+v" = "exec --no-startup-id greenclip print | head -n +2 | rofi -dmenu | xclip -selection c";
        };

        modes.resize = {
          # These bindings trigger as soon as you enter the resize mode
          "h" = "resize shrink width 100 px or 10 ppt";
          "j" = "resize grow height 100 px or 10 ppt";
          "k" = "resize shrink height 100 px or 10 ppt";
          "l" = "resize grow width 100 px or 10 ppt";

          # Back to normal: Enter or Escape or $mod+r
          "Return" = "mode \"default\"";
          "Escape" = "mode \"default\"";
          "${mod}+r" = "mode \"default\"";
        };
      };
    };
}

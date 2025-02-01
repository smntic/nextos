# My apologies for the monolithic config file; the lock script is used for both bindings and swayidle.
{ lib, pkgs, config, ... }:

let
  lockScript = pkgs.pkgs.writeShellScript "lock" ''
    ${pkgs.swaylock-effects}/bin/swaylock -f                     \
      --inside-clear-color=#${config.lib.stylix.colors.base00}80 \
      --ring-clear-color=#${config.lib.stylix.colors.base09}     \
                                                                 \
      --inside-ver-color=#${config.lib.stylix.colors.base00}80   \
      --ring-ver-color=#${config.lib.stylix.colors.base0D}       \
                                                                 \
      --inside-wrong-color=#${config.lib.stylix.colors.base00}80 \
      --ring-wrong-color=#${config.lib.stylix.colors.base08}     \
                                                                 \
      --inside-color=#${config.lib.stylix.colors.base00}80       \
      --ring-color=#${config.lib.stylix.colors.base0B}           \
      --line-color=#${config.lib.stylix.colors.base00}           \
      --separator-color=#${config.lib.stylix.colors.base00}      \
                                                                 \
      --text-color=#${config.lib.stylix.colors.base05}           \
      --text-clear-color=#${config.lib.stylix.colors.base05}     \
      --text-ver-color=#${config.lib.stylix.colors.base05}	   \
      --text-wrong-color=#${config.lib.stylix.colors.base05}     \
      --layout-text-color=#${config.lib.stylix.colors.base05}    \
                                                                 \
      --key-hl-color=#${config.lib.stylix.colors.base0B}         \
      --bs-hl-color=#${config.lib.stylix.colors.base0E}          \
                                                                 \
      --screenshots                                              \
      --effect-blur 5x5                                          \
      --clock                                                    \
                                                                 \
      --indicator-radius 80                                      \
  '';
in
  {
    home.packages = lib.mkIf config.homeModules.sway.enable [
      pkgs.cliphist
      pkgs.grim
      pkgs.mako
      pkgs.slurp
      pkgs.swaylock-effects
      pkgs.wl-clip-persist
      pkgs.wl-clipboard
    ];
  
    wayland.windowManager.sway = let
      mod = "Mod4";
      ctrl = "Control";
      alt = "Mod1";
      shift = "Shift";
  
      refreshStatus = "killall -SIGUSR1 i3status";
    in
      {
        enable = true;
        config = {
          startup = [
            { command = "--no-startup-id ${pkgs.mako}/bin/mako"; always = false; }
            { command = "--no-startup-id ${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store"; always = false; }
            { command = "--no-startup-id ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular"; always = false; }
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
            "${mod}+p" = "exec --no-startup-id grim -g \"$(slurp)\" - | wl-copy";
  
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
            "${mod}+${shift}+r" = "reload";
  
            # Resize mode
            "${mod}+r" = "mode \"resize\"";
  
            # Clipboard selection (cliphist)
            "${mod}+${shift}+v" = "exec --no-startup-id cliphist list | rofi -dmenu | cliphist decode | wl-copy";
     
            # Emoji selection
            "${mod}+e" = "exec --no-startup-id rofimoji --max-recent 0";
     
            # Notification selection
            "${mod}+n" = "exec --no-startup-id makoctl invoke";
            "${mod}+${shift}+n" = "exec --no-startup-id makoctl history | jq -r '.data.[] | to_entries[] | \"\\(.key) \\(.value.summary.data)\"' | rofi -dmenu | cut -f 1 -d ' ' | xargs -I {} makoctl invoke -n {}";
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
  
    services.swayidle = lib.mkIf config.homeModules.sway.enable {
      enable = true;
      events = [
        { event = "before-sleep"; command = "${lockScript}"; }
        { event = "lock"; command = "${lockScript}"; }
      ];
    };
  }

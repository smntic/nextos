{ pkgs, ... }:

let
  # https://github.com/hyprwm/Hyprland/issues/2321#issuecomment-1583184411
  moveWindowScript = pkgs.pkgs.writeShellScript "move_window" ''
    MOVE_SIZE=''${1:?Missing size}

    MOVE_PARAMS_X=0
    MOVE_PARAMS_Y=0

    DIRECTION=''${2:?Missing move direction}
    case $DIRECTION in
    l)
      MOVE_PARAMS_X=-$MOVE_SIZE
      ;;
    r)
      MOVE_PARAMS_X=$MOVE_SIZE
      ;;
    u)
      MOVE_PARAMS_Y=-$MOVE_SIZE
      ;;
    d)
      MOVE_PARAMS_Y=$MOVE_SIZE
      ;;
    *)
      return 1
      ;;
    esac

    MOVE_TYPE=''${3:?Missing move type}
    ACTIVE_WINDOW=$(hyprctl activewindow -j)
    IS_FLOATING=$(echo "$ACTIVE_WINDOW" | ${pkgs.jq}/bin/jq .floating)

    if [ "$MOVE_TYPE" = "move" ]; then
      if [ "$IS_FLOATING" = "true" ]; then
        hyprctl dispatch moveactive "$MOVE_PARAMS_X" "$MOVE_PARAMS_Y"
      else
        hyprctl dispatch movewindow "$DIRECTION"
      fi
    elif [ "$MOVE_TYPE" = "resize" ]; then
      hyprctl dispatch resizeactive "$MOVE_PARAMS_X" "$MOVE_PARAMS_Y"
    fi
  '';

  toggleFloatingScript = pkgs.pkgs.writeShellScript "toggle_floating" ''
    ACTIVE_WINDOW=$(hyprctl activewindow -j)
    IS_FLOATING=$(echo "$ACTIVE_WINDOW" | ${pkgs.jq}/bin/jq .floating)

    if [ "$IS_FLOATING" = "true" ]; then
      hyprctl dispatch focuswindow tiled
    else
      hyprctl dispatch focuswindow floating
    fi
  '';
in
  {
    home.packages = [
      pkgs.jq
      pkgs.hyprshot
      (pkgs.rofimoji.override { rofi = pkgs.rofi-wayland; })
      pkgs.cliphist
      pkgs.brightnessctl
    ];

    wayland.windowManager.hyprland.settings = {
      # Bindings
      "$mod" = "SUPER";
      "$alt_mod" = "ALT";

      bindle = [
      # Brightness control
      ", XF86MonBrightnessUp, exec, brightnessctl s +10%"
      ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

      # Move window
      "$mod SHIFT, h, exec, ${moveWindowScript} 100 l move"
      "$mod SHIFT, j, exec, ${moveWindowScript} 100 d move"
      "$mod SHIFT, k, exec, ${moveWindowScript} 100 u move"
      "$mod SHIFT, l, exec, ${moveWindowScript} 100 r move"

      # Resize window
      "$mod $alt_mod, h, exec, ${moveWindowScript} 100 l resize"
      "$mod $alt_mod, j, exec, ${moveWindowScript} 100 d resize"
      "$mod $alt_mod, k, exec, ${moveWindowScript} 100 u resize"
      "$mod $alt_mod, l, exec, ${moveWindowScript} 100 r resize"
      ];

      bindm = [
        # Move/resize windows with mouse
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        # Kill active window
        "$mod SHIFT, Q, killactive"

        # Full screen active window
        "$mod, F, fullscreen"

        # Run apps
        "$mod, D, exec, rofi -show drun"
        "$mod, RETURN, exec, kitty"
        "$mod, W, exec, firefox"

        # Lock screen
        "$mod CTRL, l, exec, hyprlock"

        # Move focus
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Toggle window floating
        "$mod SHIFT, SPACE, togglefloating"

        # Toggle focus between floating and tiled windows
        "$mod, SPACE, exec, ${toggleFloatingScript}"

        # Move focus between monitors
        "$mod CTRL, h, focusmonitor, l"
        "$mod CTRL, l, focusmonitor, r"

        # Move workspace between monitors
        "$mod CTRL SHIFT, h, movecurrentworkspacetomonitor, l"
        "$mod CTRL SHIFT, l, movecurrentworkspacetomonitor, r"

        # Switch workspace
        "$mod, 1, workspace, 10"
        "$mod, 2, workspace, 9"
        "$mod, 3, workspace, 8"
        "$mod, 4, workspace, 7"
        "$mod, 5, workspace, 6"
        "$mod, 6, workspace, 5"
        "$mod, 7, workspace, 4"
        "$mod, 8, workspace, 3"
        "$mod, 9, workspace, 2"
        "$mod, 0, workspace, 1"

        # Move window to workspace
        "$mod SHIFT, 1, movetoworkspacesilent, 10"
        "$mod SHIFT, 2, movetoworkspacesilent, 9"
        "$mod SHIFT, 3, movetoworkspacesilent, 8"
        "$mod SHIFT, 4, movetoworkspacesilent, 7"
        "$mod SHIFT, 5, movetoworkspacesilent, 6"
        "$mod SHIFT, 6, movetoworkspacesilent, 5"
        "$mod SHIFT, 7, movetoworkspacesilent, 4"
        "$mod SHIFT, 8, movetoworkspacesilent, 3"
        "$mod SHIFT, 9, movetoworkspacesilent, 2"
        "$mod SHIFT, 0, movetoworkspacesilent, 1"

        # Take screenshot
        "$mod, Print, exec, hyprshot --clipboard-only -m region"

        # Clipboard selection (cliphist)
        "$mod, comma, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        # Emoji selection
        "$mod, period, exec, rofimoji --max-recent 0"

        # Notification selection
        "$mod, n, exec, makoctl invoke"
        "$mod SHIFT, n, exec, makoctl history | jq -r '.data.[] | to_entries[] | \"\\(.key) \\(.value.summary.data)\"' | rofi -dmenu | cut -f 1 -d ' ' | xargs -I {} makoctl invoke -n {}"
      ];
    };
  }

{ pkgs, lib, config, inputs, ... }:

let
  setupScript = pkgs.pkgs.writeShellScript "setup" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.hyprpaper}/bin/hyprpaper &
  '';
  reloadScript = pkgs.pkgs.writeShellScript "reload" ''
  '';
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
    IS_FLOATING=$(echo "$ACTIVE_WINDOW" | jq .floating)
    
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
    IS_FLOATING=$(echo "$ACTIVE_WINDOW" | jq .floating)

    if [ "$IS_FLOATING" = "true" ]; then
      hyprctl dispatch focuswindow tiled
    else
      hyprctl dispatch focuswindow floating
    fi
  '';
in
  {
    home.packages = [
      # Wallpaper
      pkgs.swww
  
      # Bar
      pkgs.waybar
  
      # Notifications
      pkgs.mako
      pkgs.libnotify

      # Browser
      pkgs.firefox
  
      # Launcher
      pkgs.rofi-wayland

      # Brightness control
      pkgs.brightnessctl

      # Fonts
      pkgs.nerd-fonts.symbols-only
      pkgs.dejavu_fonts

      # Misc
      pkgs.jq # Required for move window script

      # Clipboard
      pkgs.wl-clipboard

      # Wallpaper
      pkgs.hyprpaper

      # Screenshot tool
      pkgs.hyprshot
    ];

    wayland.windowManager.hyprland = {
      enable = true;

      # https://wiki.hyprland.org/Useful-Utilities/Systemd-start/
      systemd.enable = false;

      settings = {
        misc = {
          # Disable splash screen
          disable_hyprland_logo = true;
          disable_splash_rendering = true;

          # Animate events like resizeactive
          animate_manual_resizes = true;
        };

        exec-once = ''${setupScript}'';
        exec = ''${reloadScript}'';

        # Bindings
        "$mod" = "SUPER";

        bindle = [
          # Brightness control
          ", XF86MonBrightnessUp, exec, brightnessctl s +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
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
          "CTRL ALT, l, exec, hyprlock"

          # Move focus
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # Move window
          "$mod SHIFT, h, exec, ${moveWindowScript} 100 l move"
          "$mod SHIFT, j, exec, ${moveWindowScript} 100 d move"
          "$mod SHIFT, k, exec, ${moveWindowScript} 100 u move"
          "$mod SHIFT, l, exec, ${moveWindowScript} 100 r move"

          # Resize window
          "$mod ALT, h, exec, ${moveWindowScript} 100 l resize"
          "$mod ALT, j, exec, ${moveWindowScript} 100 d resize"
          "$mod ALT, k, exec, ${moveWindowScript} 100 u resize"
          "$mod ALT, l, exec, ${moveWindowScript} 100 r resize"
          
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
        ];

        general = {
          gaps_in = 3;
          gaps_out = 6;
          border_size = 1;
        };

        decoration = {
          shadow = {
            enabled = false;
          };

          blur = {
            enabled = true;
            size = 4;
          };
        };

        blurls = [
          "waybar"
	  "kitty"
        ];

        animation = [
          "windows, 1, 3, default"
          "layers, 1, 3, default"
          "fade, 1, 3, default"
          "border, 1, 5, default"
          "workspaces, 1, 5, default"
        ];

        gestures = {
          workspace_swipe = true;
        };

        # Input config
        input = {
          # Global mouse config
          accel_profile = "flat";
          
          # Global keyboard config
          kb_layout = "us";
          kb_variant = "";
          #kb_variant = "colemak_dh";
          kb_options = "caps:escape";
        };
        device = [
          {
            name = "elan06c2:00-04f3:3195-touchpad";
            accel_profile = "adaptive";
            natural_scroll = true;
          }
        ];

        # Monitor settings
        monitor = [
          "eDP-1, preferred, 0x0, 1"
          ", preferred, auto, 1"
        ];
        workspace = [
          "1, monitor:eDP-1"
        ];
        cursor = {
          default_monitor = "eDP-1";
        };
      };
    };

    programs = {
      hyprlock = {
        enable = true;
        
        settings = {
          general = {
            disable_loading_bar = true;
            hide_cursor = true;
            no_fade_in = true;
            no_fade_out = true;
          };

	  background = lib.mkForce [
            {
	      path = "screenshot";
	      blur_passes = 2;
	      blur_size = 5;
	    }
	  ];

	  input-field = lib.mkForce [
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
        };
      };

      waybar = {
        enable = true;
        settings.mainBar = {
          modules-left = [ "hyprland/workspaces" ];
          modules-right = [
            "network"
            "custom/separator"
            "disk"
            "custom/separator"
            "memory"
            "custom/separator"
            "battery"
            "custom/separator"
            "wireplumber"
          ];
  
          network = {
            format-wifi = "󰖩 {essid} {signalStrength}% : {ipaddr}";
            format-ethernet = "󰈀 {cidr} : {ipaddr}";
            format-disconnected = "󰖪 Disconnected";
            interval = 1;
            tooltip = false;
          };
  
          disk = {
            format = "󰗮 {specific_free:0.1f} GB";
            unit = "GB";
            interval = 1;
            tooltip = false;
          };
  
          memory = {
            format = "󰍛 {used:0.1f} GB";
            interval = 1;
            tooltip = false;
          };
  
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            "format-charging" = "󱐥 {capacity}%";
            "format-discharging" = "󱐤 {capacity}%";
            "format-full" = "󰚥 {capacity}%";
            "format-not charging" = "󰚥 {capacity}%";
            "format-unknown" = " {capacity}%";
            interval = 1;
            tooltip = false;
          };
  
          wireplumber = {
            format = "󰎇 {volume}%";
            format-muted = "󰎊 {volume}%";
            interval = 1;
            tooltip = false;
          };
  
          "custom/separator" = {
            format = "|";
            interval = "once";
            tooltip = false;
          };
        };
  
        style = ''
          * {
            font-family: 'monospace';
          }

          #workspaces button {
            padding: 0 0.5em;
            border-radius: 0;
          }

          #workspaces button:hover {
            background: alpha(@base05, 0.2);
          }

          #workspaces button.active {
            background: alpha(@base05, 0.1);
          }

          #workspaces button.active:hover {
            background: alpha(@base05, 0.2);
          }

          .modules-right label.module {
            margin-right: 0.5em;
          }

          #network.wifi, #network.linked, #network.ethernet {
            color: @base0B;
          }

          #network.disabled, #network.disconnected {
            color: @base08;
          }

          #wireplumber.muted {
            color: @base0C;
          }

          #custom-separator {
            color: @base04;
          }
        '';
      };

      kitty = {
        enable = true;

        keybindings = {
          # Disable tab bindings
          "kitty_mod+t" = "no_op";
          "kitty_mod+q" = "no_op";
          "kitty_mod+alt+t" = "no_op";

          # Disable window bindings
          "kitty_mod+enter" = "no_op";
          "kitty_mod+n" = "no_op";
          "kitty_mod+w" = "no_op";
          "kitty_mod+r" = "no_op";
        };

        # Disable warning on close
        extraConfig = ''
          confirm_os_window_close 0
        '';
      };

      tmux = {
        enable = true;

        prefix = "C-space";

        shell = "${pkgs.zsh}/bin/zsh";
        extraConfig = ''
          set -s escape-time = 0
          set -g status-right ""
          set -g repeat-time 1000

          unbind Left
          unbind Down
          unbind Up
          unbind Right

          unbind C-Left
          unbind C-Down
          unbind C-Up
          unbind C-Right

          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          bind-key -r C-h resize-pane -L 5
          bind-key -r C-j resize-pane -D 5
          bind-key -r C-k resize-pane -U 5
          bind-key -r C-l resize-pane -R 5
        '';
      };
    };

    services = {
      hyprpaper = {
        enable = true;

        settings = {
          preload = [ "${../assets/wallpapers/forest.png}" ];
          wallpaper = [ ",${../assets/wallpapers/forest.png}" ];
        };
      };
    };
  }

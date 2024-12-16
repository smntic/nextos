{ pkgs, inputs, ... }:

let
  loadWallpaper = pkgs.pkgs.writeShellScript "load_wallpaper" ''
    ${pkgs.swww}/bin/swww img ${../assets/wallpapers/sakura.gif} &
  '';

  startupScript = pkgs.pkgs.writeShellScript "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 0.5

    ${loadWallpaper}
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
  
      # Terminal
      pkgs.kitty

      # Browser
      pkgs.firefox
  
      # Launcher
      pkgs.rofi-wayland

      # Brightness control
      pkgs.brightnessctl

      # Fonts
      pkgs.nerd-fonts.symbols-only
      pkgs.ibm-plex
      pkgs.ark-pixel-font

      # Misc
      pkgs.jq # Required for move window script
    ];

    # Font config
    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [ "IBM Plex Mono" ];
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        misc = {
	  # Disable splash screen
          disable_hyprland_logo = true;
	  disable_splash_rendering = true;

	  # Animate events like resizeactive
	  animate_manual_resizes = true;
	};

	# Monitor settings
	monitor = ", preferred, auto, 1";


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
        ] ++ (
	  # Switch workspaces
	  builtins.concatLists (builtins.genList (i:
	    let
	      binding = i + 1;
	      workspace = i + 1;  # changing for now TODO: maybe reverse...
	    in [
	      "$mod, ${toString binding}, workspace, ${toString workspace}"
	      "$mod SHIFT, ${toString binding}, movetoworkspacesilent, ${toString workspace}"
	    ]
	  ) 9)
	);

        exec-once = ''${startupScript}'';

        general = {
          gaps_in = 3;
	  gaps_out = 6;
	  border_size = 1;
  
  	  "col.active_border" = "rgba(FFFFFFFF)";
  	  "col.inactive_border" = "rgba(AAAAAAFF)";
        };

	decoration = {
          shadow = {
            enabled = false;
	  };
	};

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
      };
    };

    programs.waybar = {
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
	  font-family: 'Ark Pixel 12px Monospaced latin';
	  font-size: 16px;
        }
        
        window#waybar {
          background: rgb(37, 107, 139);
        }
        
        #workspaces button {
          margin-right: 0.2em;
          padding: 0 0.5em;
          color: white;
	  border: none;
          border-bottom: 4px solid transparent;
          border-radius: 0;
        }
        
        #workspaces button:hover {
          background: rgba(255, 255, 255, 0.2);
          box-shadow: inherit;
        }
                
        #workspaces button.active {
          background: rgba(255, 255, 255, 0.1);
	  border-color: rgb(240, 160, 190);
        }

	#workspaces button.active:hover {
          background: rgba(255, 255, 255, 0.2);
	}
        
        .modules-right label.module {
          color: rgb(220, 220, 220);
          margin-right: 0.5em;
        }

        #network.wifi, #network.linked, #network.ethernet {
          color: rgb(120, 230, 140);
        }
        
        #network.disabled, #network.disconnected {
          color: rgb(225, 100, 80);
        }
        
        #wireplumber.muted {
          color: rgb(225, 100, 80);
        }

	#custom-icon {
	  font-size: 1.3em;
          color: rgb(50, 140, 235);
	  margin-left: 0.3em;
	}

	#custom-separator {
          color: rgb(180, 180, 180);
	}
      '';
    };
  }

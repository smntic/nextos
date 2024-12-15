{ pkgs, inputs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 0.5

    ${pkgs.swww}/bin/swww img ${./black.jpg} &
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
      pkgs.dejavu_fonts
    ];

    # Font config
    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [ "DejaVu Sans Mono" ];
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        misc = {
	  # Disable splash screen
          disable_hyprland_logo = true;
	  disable_splash_rendering = true;
	};

	# Monitor settings
	monitor = ", preferred, auto, 1";

        "$mod" = "SUPER";

        bindle = [
	  # Brightness control
          ", XF86MonBrightnessUp, exec, brightnessctl s +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
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

	  # Move window position
	  "$mod SHIFT, h, movewindow, l"
	  "$mod SHIFT, l, movewindow, r"
	  "$mod SHIFT, k, movewindow, u"
	  "$mod SHIFT, j, movewindow, d"
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

        exec-once = ''${startupScript}/bin/start'';
      };
    };

    programs.waybar = {
      enable = true;
      settings.mainBar = {
        modules-left = [ "custom/icon" "hyprland/workspaces" ];
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

	"custom/icon" = {
	  format = " ";
          interval = "none";
	  tooltip = false;
	};

	"custom/separator" = {
	  format = "|";
          interval = "none";
	  tooltip = false;
	};
      };

      style = ''
        * {
          font-family: monospace;
        }
        
        window#waybar {
          background: rgba(70, 70, 70, 0.5);
          padding: 0.5em;
        }
        
        #workspaces button {
          margin: 0 0.2em;
          padding: 0 0.5em;
          color: white;
          border: 1px solid transparent;
        }
        
        #workspaces button:hover {
          background: rgba(100, 100, 100, 0.5);
          box-shadow: inherit;
        }
                
        #workspaces button.active {
          border-bottom: 1px solid blue;
          border-radius: 0;
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

{ pkgs, lib, config, ... }:

let
  setupScript = pkgs.pkgs.writeShellScript "setup" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.hyprpaper}/bin/hyprpaper &
    ${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store &
    ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular &
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
      pkgs.libnotify

      # Brightness control
      pkgs.brightnessctl

      # Clipboard
      pkgs.wl-clipboard

      # Wallpaper
      pkgs.hyprpaper

      # Screenshot tool
      pkgs.hyprshot

      # Bluetooth management
      pkgs.bluetui

      # Emoji selection
      pkgs.rofimoji

      # Misc
      pkgs.jq              # Required for move window script
      pkgs.cliphist        # Clipboard manager
      pkgs.wl-clip-persist # Keeps clipboard even after programs close
    ];

    wayland.windowManager.hyprland = {
      enable = true;

      # https://wiki.hyprland.org/Useful-Utilities/Systemd-start/
      # systemd.enable = false;

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

	  # Global touchpad config
          touchpad = {
            scroll_factor = 0.3;
	  };
          
          # Global keyboard config
          kb_layout = "us";
          kb_variant = "";
          #kb_variant = "colemak_dh";
          kb_options = "caps:escape";
	  repeat_rate = 30;
	  repeat_delay = 300; 
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

	  #workspaces button.urgent {
	    background: alpha(@base08, 0.3);
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
            color: @base09;
          }

          #custom-separator {
            color: @base04;
          }
        '';
      };

      rofi = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        enable = true;

	extraConfig = {
	  modi = "drun,run";
          show-icons = true;
	  fuzzy = true;
          terminal = "kitty";

	  # https://www.reddit.com/r/qtools/comments/kaiaa8/comment/i4ifgyf
          kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
          kb-row-down = "Down,Control+j";
          kb-accept-entry = "Control+m,Return,KP_Enter";
          kb-remove-to-eol = "Control+Shift+e";
          kb-mode-next = "Shift+Right,Control+Tab,Control+l";
          kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
          kb-remove-char-back = "BackSpace";
	  kb-cancel = "Escape,Control+c";
	  kb-mode-complete = ""; # Otherwise bound to Control+l
	};

	theme = {
          "*" = {
            width = 512;
	  };

	  window = {
            border = mkLiteral "1px";
	    border-color = mkLiteral config.lib.stylix.colors.withHashtag.base0D;
	  };
          
	  inputbar = {
            padding = mkLiteral "5px";
            spacing = mkLiteral "5px";
	  };

	  prompt = {
            font = "monospace 14px";
	  };

	  entry = {
            font = "monospace 14px";
	  };
	
	  listview = {
            lines = 10;
	  };

          element = {
            padding = mkLiteral "5px";
            spacing = mkLiteral "10px";
	  };

	  element-text = {
            font = "monospace 14px";
	  };
	};
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
	  enable_audio_bell no
        '';
      };

      tmux = {
        enable = true;

        prefix = "C-space";

        shell = "${pkgs.zsh}/bin/zsh";
        extraConfig = ''
          set -s escape-time 0
          set -g status-right ""
          set -g repeat-time 1000
          set -g default-terminal "screen-256color"
          set -as terminal-features ",xterm-256color:RGB"

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

      yazi = {
        enable = true;
	enableZshIntegration = true;

	theme = {
          status = {
            separator_open = "";
            separator_close = "";
	  };
	};
      };

      # Dear firefox, fuck you kindly.
      firefox = 
        let
	  lock = value: {
	    Value = value;
	    Status = "locked";
	  };
	in
	  {
            enable = true;

	    policies = {
              AppAutoUpdate = false;
	      BackgroundAppUpdate = false;
	      DisableFirefoxAccounts = true;
	      DisableFirefoxStudies = true;
	      DisableHardwareAcceleration = true;
	      DisableSetDesktopBackground = true;
	      DisablePrivateBrowsing = true;
	      DisablePocket = true;
	      DisableTelemetry = true;
	      DisableFormHistory = true;
	      DisablePasswordReveal = true;
	      DisplayBookmarksToolbar = "never";
	      DontCheckDefaultBrowser = true;
	      ExtensionUpdate = false;
	      FirefoxSuggest = false;
	      OfferToSaveLogins = false;
              SearchSuggestEnabled = false;

	      Preferences = {
                "browser.urlbar.suggest.topsites" = lock false;
                "browser.topsites.contile.enabled" = lock false;
		"browser.newtabpage.activity-stream.feeds.snippets" = lock false;
		"browser.newtabpage.activity-stream.feeds.topsites" = lock false;
		"browser.newtabpage.activity-stream.showSponsored" = lock false;
		"browser.newtabpage.activity-stream.system.showSponsored" = lock false;
		"browser.newtabpage.activity-stream.showSponsoredTopSites" = lock false;
		"browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = lock false;
		"browser.uiCustomization.state" = lock "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"ublock0_raymondhill_net-browser-action\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"unified-extensions-area\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":20,\"newElementCount\":2}";
	      };

	      ExtensionSettings =
                let
		  extension = shortId: uuid: {
                    name = uuid;
	    	    value = {
                      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
	    	      installation_mode = "normal_installed";
	    	    };
	          };
	        in
	          builtins.listToAttrs [
                    (extension "ublock-origin" "uBlock0@raymondhill.net")
                    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
                    (extension "darkreader" "addon@darkreader.org")
                    (extension "600-sound-volume" "{c4b582ec-4343-438c-bda2-2f691c16c262}")
                    (extension "youtube-recommended-videos" "myallychou@gmail.com")
	          ];
	    };

	    profiles.default = {
	      id = 0;
	      name = "default";
	      isDefault = true;

	      settings = {
                "browser.startup.homepage" = "about:newtab";
	      };
	    };
          };
    };

    services = {
      hyprpaper = {
        enable = true;

        settings = {
          preload = [ "${config.stylix.image}" ];
          wallpaper = [ ",${config.stylix.image}" ];
        };
      };

      mako = {
        enable = true;
	defaultTimeout = 3000;
      };


      gammastep = {
        enable = true;

	# Approximately Vancouver
	provider = "manual";
	latitude = 49.3;
	longitude = -123.1;

	temperature = {
          day = 5500;
	  night = 3000;
	};

	# Specify the times to align with my sleep "schedule"
        dawnTime = "6:00-7:00";
	duskTime = "21:00-22:00";
      };
    };
  }

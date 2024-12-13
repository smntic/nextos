{ pkgs, inputs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 0.5

    ${pkgs.swww}/bin/swww img ${./nyan.gif} &
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
    ];

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        misc = {
	  # Disable splash screen
          disable_hyprland_logo = true;
	  disable_splash_rendering = true;
	};


        ### Keybindings (maybe put this into another module in the future???
        "$mod" = "SUPER";

        bindle = [
	  # Brightness control
          ", XF86MonBrightnessUp, exec, brightnessctl s +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
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
	      workspace = 9 - i;
	    in [
	      "$mod, ${toString binding}, workspace, ${toString workspace}"
	      "$mod SHIFT, ${toString binding}, movetoworkspacesilent, ${toString workspace}"
	    ]
	  ) 9)
	);

        exec-once = ''${startupScript}/bin/start'';
      };
    };
  }

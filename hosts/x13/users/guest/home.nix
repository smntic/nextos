{ pkgs, inputs, ... }:

{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  home = {
    packages = [
      pkgs.neofetch
    ];

    stateVersion = "24.11";
  };

  programs = {
    bash = {
      enable = true;
      # Start plasma upon login
      initExtra = ''
        if [ -z "$WAYLAND_DISPLAY" ]; then
          startplasma-wayland
          logout
        fi
      '';
    };
  };
}

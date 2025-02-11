{ pkgs, inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  environment.systemPackages = [
    pkgs.capitaine-cursors
  ];

  fonts.packages = [
    pkgs.noto-fonts
    (pkgs.nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
  ];

  stylix = {
    enable = true;

    # Wallpaper
    image = ./assets/wallpapers/red_storm.jpg;

    # Currently, accessing these properties from config does not work if they are not strings.
    # Thus, I copied these values from "tokyo-city-terminal-dark" (base16).
    base16Scheme = {
      base00 = "#171D23";
      base01 = "#1D252C";
      base02 = "#28323A";
      base03 = "#526270";
      base04 = "#B7C5D3";
      base05 = "#D8E2EC";
      base06 = "#F6F6F8";
      base07 = "#FBFBFD";
      base08 = "#D95468";
      base09 = "#FF9E64";
      base0A = "#EBBF83";
      base0B = "#8BD49C";
      base0C = "#70E1E8";
      base0D = "#539AFC";
      base0E = "#B62D65";
      base0F = "#DD9D82";
    };

    opacity = {
      desktop = 0.5;
      terminal = 0.8;
    };

    cursor = {
      name = "capitaine-cursors";
      size = 16;
    };

    fonts = {
      sizes = {
        applications = 11;
        desktop = 10;
        popups = 10;
        terminal = 11;
      };
    };

    targets = {
      # Do not theme the TTY
      console.enable = false;

      # Do not theme the grub bootloader
      grub.enable = false;
    };
  };

  environment.variables = {
    QT_FONT_DPI = 86;
  };
}

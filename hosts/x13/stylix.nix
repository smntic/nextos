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
    image = ./assets/wallpapers/sunset_torii.jpg;

    base16Scheme = {
      base00 = "#0f1423";
      base01 = "#171f34";
      base02 = "#1f2946";
      base03 = "#4f67af";
      base04 = "#7285bf";
      base05 = "#b8c2df";
      base06 = "#edeff7";
      base07 = "#ffffff";
      base08 = "#e05358";
      base09 = "#dbb896";
      base0A = "#8a97de";
      base0B = "#96db96";
      base0C = "#9696db";
      base0D = "#f9a29e";
      base0E = "#e87b7b";
      base0F = "#c5abb5";
    };

    opacity = {
      desktop = 0.4;
      terminal = 0.95;
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

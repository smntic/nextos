{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.capitaine-cursors
  ];

  fonts.packages = [
    pkgs.noto-fonts
    pkgs.nerd-fonts.symbols-only
  ];

  stylix = {
    enable = true;

    image = ./assets/wallpapers/forest.png;
    base16Scheme = {
      base00 = "171D23";
      base01 = "1D252C";
      base02 = "28323A";
      base03 = "526270";
      base04 = "B7C5D3";
      base05 = "D8E2EC";
      base06 = "F6F6F8";
      base07 = "FBFBFD";
      base08 = "D95468";
      base09 = "FF9E64";
      base0A = "EBBF83";
      base0B = "8BD49C";
      base0C = "70E1E8";
      base0D = "539AFC";
      base0E = "B62D65";
      base0F = "DD9D82";
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

      serif = {
        package = pkgs.noto-fonts;
	name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
	name = "Noto Sans Serif";
      };

      monospace = {
        package = pkgs.noto-fonts;
	name = "Noto Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts;
	name = "Noto Color Emoji";
      };
    };

    targets = {
      console.enable = false;
      grub.enable = false;
    };
  };
}

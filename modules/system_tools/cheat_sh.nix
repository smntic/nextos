{ lib, config, pkgs, ... }:

let
  cheatSh = pkgs.stdenv.mkDerivation {
    pname = "cht-sh";
    version = "latest";

    src = pkgs.fetchurl {
      url = "https://cht.sh/:cht.sh";
      sha256 = "0mgi662b5j0d3ccw5880xg3y5x7h03jxzm24mix2xzq0p115w4yk";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/cht.sh
      chmod +x $out/bin/cht.sh
    '';

    meta = with pkgs.lib; {
      description = "cht.sh CLI client for accessing programming cheatsheets";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  };
in
  {
    options = {
      modules.cheat-sh.enable = lib.mkEnableOption "cheat.sh";
    };
  
    config = lib.mkIf config.modules.cheat-sh.enable {
      environment.systemPackages = [ cheatSh ];
    };
  }

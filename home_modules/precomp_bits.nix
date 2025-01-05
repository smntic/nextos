{ pkgs, lib, config, ... }:

let
  precompBits = pkgs.stdenv.mkDerivation {
    pname = "precomp-bits";
    version = "1.0";

    # Skip unpack phase as there is no source to unpack
    dontUnpack = true;

    buildPhase = ''
      mkdir -p $out
      export BITS_PATH=${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}/$(gcc -dumpmachine)/bits/
      cp $BITS_PATH/stdc++.h $out/
      ${pkgs.gcc}/bin/g++ -x c++-header $out/stdc++.h -o $out/stdc++.h.gch
    '';
  };
in
  {
    options = {
      homeModules.precomp-bits.enable = lib.mkEnableOption "precomputation of bits/stdc++ header file";
      homeModules.precomp-bits.out = lib.mkOption {
        type = lib.types.str;
        description = "path to the precomp-bits derivation output";
      };
    };
    
    config = lib.mkIf config.homeModules.precomp-bits.enable {
      home.packages = [ precompBits ];
      homeModules.precomp-bits.out = builtins.toString precompBits.out;
    };
  }

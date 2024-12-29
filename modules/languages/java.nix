{ pkgs, lib, config, ... }:

{
  options = {
    java.enable = lib.mkEnableOption "java";
  };

  config = lib.mkIf config.java.enable {
    programs.java = {
      enable = true;
      package = pkgs.jdk21;
    };
  };
}

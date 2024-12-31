{ pkgs, lib, config, ... }:

{
  options = {
    modules.java.enable = lib.mkEnableOption "java";
  };

  config = lib.mkIf config.modules.java.enable {
    programs.java = {
      enable = true;
      package = pkgs.jdk21;
    };
  };
}

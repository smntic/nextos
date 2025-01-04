{ pkgs, lib, config, inputs, ... }:

{
  options = {
    homeModules.cp-tool.enable = lib.mkEnableOption "cp-tool";
  };

  config = lib.mkIf config.homeModules.cp-tool.enable {
    home.packages = [
      inputs.cp-tool.packages.${pkgs.system}.cptool-py
    ];
  };
}

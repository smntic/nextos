{ lib, config, ... }:

{
  options = {
    modules.docker.enable = lib.mkEnableOption "docker";
  };

  config = lib.mkIf config.modules.docker.enable {
    virtualisation.docker.enable = true;
  };
}

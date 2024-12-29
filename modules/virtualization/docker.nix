{ lib, config, ... }:

{
  options = {
    docker.enable = lib.mkEnableOption "docker";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker.enable = true;
  };
}

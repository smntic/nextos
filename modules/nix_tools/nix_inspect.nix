{ pkgs, lib, config, inputs, ... }:

{
  options = {
    modules.nix-inspect.enable = lib.mkEnableOption "nix-inspect";
  };

  config = lib.mkIf config.modules.nix-inspect.enable {
    environment.systemPackages = [
      inputs.nix-inspect.packages.${pkgs.system}.default
    ];
  };
}

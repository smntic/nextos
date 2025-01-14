{ pkgs, lib, config, ... }:

{
  options = {
    homeModules.python.packages = lib.mkOption {
      type = lib.types.functionTo (lib.types.listOf lib.types.package);
      description = "Lambda mapping from package to names of python packages to install.";
      example = "p: with p; [ numpy ]";
      default = p: [];
    };
  };

  config = {
    home.packages = [
      # Magic trick:
      (pkgs.python3.withPackages
        config.homeModules.python.packages
      )
    ];
  };
}

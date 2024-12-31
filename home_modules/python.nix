{ pkgs, lib, config, ... }:

{
  options = {
    homeModules.python.packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Names of Python packages to install.";
      example = "[ \"numpy\" ]";
      default = [];
    };
  };

  config = {
    home.packages = [
      # Magic trick:
      (pkgs.python3.withPackages
        (p:
          config.homeModules.python.packages
        )
      )
    ];
  };
}

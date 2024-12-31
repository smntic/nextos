{ lib, config, ... }:

{
  options = {
    homeModules.git.enable = lib.options.mkEnableOption "git";
    homeModules.git.name = lib.options.mkOption {
      type = lib.types.str;
      description = "Name to display when using git.";
      example = "John Doe";
    };
    homeModules.git.email = lib.options.mkOption {
      type = lib.types.str;
      description = "Email to use for git.";
      example = "johndoe@domain.com";
    };
  };

  config = lib.mkIf config.homeModules.git.enable {
    programs.git = {
      enable = true;

      userName = config.homeModules.git.name;
      userEmail = config.homeModules.git.email;
    };
  };
}

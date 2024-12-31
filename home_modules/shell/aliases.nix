{ lib, config, ... }:

{
  options = {
    homeModules.aliases = lib.mkOption {
      type = lib.types.attrs;
      description = "Aliases for the user's shell. Format: `{ alias = \"command\"; ... }`";
      example = "{ goodbye = \"sudo shutdown -h now\"; }";
      default = {};
    };
  };

  config = {
    home.shellAliases = config.homeModules.aliases;

    # Enable bash so the aliases affect bash (the user can change their default shell otherwise)
    programs.bash.enable = true;
  };
}

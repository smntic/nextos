{ lib, config,... }:

{
  options = {
    homeModules.yazi.enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf config.homeModules.yazi.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;

      theme = {
        status = {
          # I don't like the default "pills"
          separator_open = "";
          separator_close = "";
        };
      };
    };
  };
}

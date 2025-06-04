{ lib, pkgs, config, inputs, ... }:

{
  options = {
    homeModules.yazi.enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf config.homeModules.yazi.enable {
    home.packages = [ pkgs.ripdrag ];

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      package = inputs.yazi.packages.${pkgs.system}.default;

      theme = {
        status = {
          # I don't like the default "pills"
          # ...but this doesn't work anymore...
          # separator_open = "";
          # separator_close = "";
        };
      };

      keymap = {
        mgr.prepend_keymap = [
          {
            on = [ "R" ];
            run = "shell 'ripdrag \"$@\" -x 2>/dev/null &' --confirm";
            desc = "Ripdrag: Select current file";
          }
        ];
      };
    };
  };
}

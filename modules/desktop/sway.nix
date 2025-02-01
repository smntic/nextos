{ lib, config, ... }:

{
  options = {
    modules.sway.enable = lib.mkEnableOption "sway";
    # modules.sway.withUWSM = lib.mkEnableOption "UWSM for sway";
  };

  config = lib.mkIf config.modules.sway.enable {
    programs.sway.enable = true;
    # programs.uwsm = lib.mkIf config.modules.sway.withUWSM {
    #   enable = true;
    #   waylandCompositors.sway = {
    #     prettyName = "Sway";
    #     comment = "Sway compositor managed by UWSM";
    #     binPath = "${pkgs.sway}/bin/sway";
    #   };
    # };
  };
}


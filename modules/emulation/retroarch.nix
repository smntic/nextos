{ pkgs, lib, config, ... }:

{
  options = {
    modules.retroarch = {
      enable = lib.mkEnableOption "retroarch";
      cores = lib.mkOption {
        default = (cores: []);
        description = "List of RetroArch cores to enable.";
      };
    };
  };

  config = lib.mkIf config.modules.retroarch.enable {
    environment.systemPackages = [
      # After 24.11:
      (pkgs.retroarch.withCores (config.modules.retroarch.cores))

      # 24.11:
      # (pkgs.retroarch.override {
      #   cores = config.modules.retroarch.cores;
      # })
    ];
  };
}

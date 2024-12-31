{ pkgs, lib, config, ... }:

{
  options = {
    modules.ghidra.enable = lib.mkEnableOption "ghidra";
  };

  config = lib.mkIf config.modules.ghidra.enable {
    environment.systemPackages = [ pkgs.ghidra ];
  };
}

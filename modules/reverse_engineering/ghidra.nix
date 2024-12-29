{ pkgs, lib, config, ... }:

{
  options = {
    ghidra.enable = lib.mkEnableOption "ghidra";
  };

  config = lib.mkIf config.ghidra.enable {
    environment.systemPackages = [ pkgs.ghidra ];
  };
}

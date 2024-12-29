{ lib, ... }:

{
  imports = [
    ./system_tools/cloc.nix
    ./system_tools/psmisc.nix
    ./system_tools/tree.nix
  ];

  cloc.enable = lib.mkDefault true;
  psmisc.enable = lib.mkDefault true;
  tree.enable = lib.mkDefault true;
}

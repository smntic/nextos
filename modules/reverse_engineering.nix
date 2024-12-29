{ lib, ... }:

{
  imports = [ 
    ./reverse_engineering/ghidra.nix
  ];

  ghidra.enable = lib.mkDefault true;
}

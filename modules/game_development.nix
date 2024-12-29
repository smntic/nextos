{ lib, ... }:

{
  imports = [
    ./game_development/blender.nix
    ./game_development/godot.nix
  ];

  blender.enable = lib.mkDefault true;
  godot.enable = lib.mkDefault true;
}

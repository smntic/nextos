{ ... }:

{
  imports = [
    ./kitty/bindings.nix
    ./kitty/config.nix
  ];

  programs.kitty.enable = true;
}

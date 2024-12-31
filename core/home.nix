{ root, ... }:

{
  imports = [
    "${root}/home_modules/desktop.nix"
    "${root}/home_modules/nvim.nix"
    "${root}/home_modules/python.nix"
    "${root}/home_modules/shell.nix"
    "${root}/home_modules/xdg.nix"
  ];
}

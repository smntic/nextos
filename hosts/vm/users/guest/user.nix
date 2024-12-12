{ pkgs, root, ... }:

{
  imports = [
    "${root}/modules/desktop/plasma.nix" 
  ];

  users.users.guest = {
    initialPassword = "guest";
    isNormalUser = true;
    extraGroups = [];
  };

  home-manager.users.guest = import ./home.nix { inherit pkgs; };
}

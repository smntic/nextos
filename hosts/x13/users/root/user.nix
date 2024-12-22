{ pkgs, ... }:

{
  users.users.root = {
    isSystemUser = true;
  };

  home-manager.users.root = import ./home.nix { inherit pkgs; };
}

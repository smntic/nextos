{ pkgs, inputs, ... }@args:

{
  users.users.root = {
    isSystemUser = true;
  };

  home-manager.users.root = import ./home.nix args;
}

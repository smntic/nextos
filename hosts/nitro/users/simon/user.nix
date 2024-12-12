{ pkgs, root, ... }:

{
  imports = [
    "${root}/modules/desktop/hyprland.nix"
  ];

  users.users.simon = {
    initialPassword = "correctHorseBatteryStaple";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.simon = import ./home.nix { inherit pkgs; };
}

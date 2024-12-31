{ pkgs, lib, config, ... }:

{
  imports = [
    ./zsh/config.nix
    ./zsh/plugins.nix
    ./zsh/init.nix
    ./zsh/env.nix
  ];

  options = {
    homeModules.zsh.enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf config.homeModules.zsh.enable {
    # Set default shell for this user
    systemd.user.sessionVariables = {
      SHELL = "${pkgs.zsh}/bin/zsh";
    };

    programs.zsh = {
      enable = true;
    };
  };
}

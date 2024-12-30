{ pkgs, ... }:

{
  imports = [
    ./zsh/config.nix
    ./zsh/plugins.nix
    ./zsh/init.nix
    ./zsh/env.nix
  ];

  systemd.user.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  programs.zsh = {
    enable = true;
  };
}

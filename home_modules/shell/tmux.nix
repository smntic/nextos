{ pkgs, lib, config, ... }:

{
  options = {
    homeModules.tmux.enable = lib.mkEnableOption "tmux";
  };

  # config = lib.mkIf config.homeModules.tmux.enable {
  config = {
    programs.tmux = {
      enable = true;

      shell = "${pkgs.zsh}/bin/zsh";
      prefix = "C-space";

      extraConfig = ''
        set -s escape-time 0
        set -g status-right ""
        set -g repeat-time 1000
        set -g default-terminal "screen-256color"
        set -as terminal-features ",xterm-256color:RGB"

        unbind Left
        unbind Down
        unbind Up
        unbind Right

        unbind C-Left
        unbind C-Down
        unbind C-Up
        unbind C-Right

        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        bind-key -r C-h resize-pane -L 5
        bind-key -r C-j resize-pane -D 5
        bind-key -r C-k resize-pane -U 5
        bind-key -r C-l resize-pane -R 5
      '';
    };
  };
}

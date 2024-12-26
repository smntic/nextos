{ pkgs, ... }:

{
  home.packages = [
    pkgs.fzf
    pkgs.thefuck
  ];

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;

    defaultKeymap = "emacs";

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-autosuggestions"
	"romkatv/powerlevel10k"
      ];
    };

    history = {
      append = true;
      extended = true;
      ignoreDups = true;
    };

    initExtraFirst = ''
      # Enable powerlevel10k instant prompt
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    initExtra = ''
      source <(fzf --zsh)
      source ${./p10k.zsh}

      # Configure thefuck alias
      eval ''$(thefuck --alias)

      # Fix for suggestion font color in tmux (https://github.com/zsh-users/zsh-autosuggestions/issues/229)
      export TERM=xterm-256color

      # fzf widget to automatically run history item after accepting
      fzf-auto-history-widget() {
        fzf-history-widget && zle accept-line
      }

      # fzf widget to automatically run command with file after accepting
      fzf-auto-file-widget() {
        fzf-file-widget && zle accept-line
      }

      # Quick run tmux function
      run-tmux-widget() {
        tmux <>$TTY
	zle redisplay
      }

      # Quick run yazi function
      run-yazi-widget() {
        yazi <>$TTY
	zle redisplay
      }

      # Create the widgets
      zle -N fzf-auto-history-widget
      zle -N fzf-auto-file-widget
      zle -N run-tmux-widget
      zle -N run-yazi-widget

      # fzf cd bindings
      bindkey '^F' fzf-cd-widget

      # fzf history bindings
      bindkey '^R' fzf-auto-history-widget
      bindkey '^[r' fzf-history-widget

      # fzf file bindings
      bindkey '^T' fzf-auto-file-widget
      bindkey '^[t' fzf-file-widget

      # Quick program bindings
      bindkey '^[[116;6u' run-tmux-widget
      bindkey '^[f' run-yazi-widget

      # Delete forward
      bindkey '\e[3~' delete-char
      
      # Delete forward a word
      bindkey '^[[3;3~' delete-word
      bindkey '^[[3;5~' delete-word
      bindkey '^[[3;7~' delete-word
      
      # Delete backward a word
      bindkey '^H' backward-delete-word
      
      # Move backward a word
      bindkey '^[[1;3D' backward-word
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;7D' backward-word
      
      # Move forward a word
      bindkey '^[[1;3C' forward-word
      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;7C' forward-word
      
      # Move to home/end
      bindkey '^[[H' beginning-of-line
      bindkey '^[[1~' beginning-of-line
      bindkey '^[[F' end-of-line
      bindkey '^[[4~' end-of-line
      
      # Change the definition of a "word"
      WORDCHARS=''${WORDCHARS//\//}
      WORDCHARS=''${WORDCHARS//-}
      WORDCHARS=''${WORDCHARS//.}
      WORDCHARS=''${WORDCHARS//\\}
    '';

    envExtra = ''
      export CPP_TEMPLATE=${../cp/cpp_template.cpp}
    '';
  };
}

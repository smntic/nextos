{ pkgs, ... }:

{
  home.packages = [
    pkgs.fzf
  ];

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;

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

      # fzf widget to automatically run history item after accepting
      fzf-auto-history-widget() {
        fzf-history-widget
	zle accept-line
      }

      # fzf widget to automatically run command with file after accepting
      fzf-auto-file-widget() {
        fzf-file-widget
	zle accept-line
      }

      # Create the widgets
      zle -N fzf-auto-history-widget
      zle -N fzf-auto-file-widget

      # fzf cd bindings
      bindkey '^F' fzf-cd-widget

      # fzf history bindings
      bindkey '^R' fzf-auto-history-widget
      bindkey '^[r' fzf-history-widget

      # fzf file bindings
      bindkey '^T' fzf-auto-file-widget
      bindkey '^[t' fzf-file-widget

      # Delete forward
      bindkey '\e[3~' delete-char
      
      # Delete forward a word
      bindkey '^[[3;3~' delete-word
      bindkey '^[[3;5~' delete-word
      bindkey '^[[3;7~' delete-word
      
      # Delete backward a word
      bindkey '^H' backward-delete-word
      
      # Move backward a word
      bindkey ';3D' backward-word
      bindkey ';5D' backward-word
      bindkey ';7D' backward-word
      
      # Move forward a word
      bindkey ';3C' forward-word
      bindkey ';5C' forward-word
      bindkey ';7C' forward-word
      
      # Move to home/end
      bindkey '^[[H' beginning-of-line
      bindkey '^[[F' end-of-line
      
      # Change the definition of a "word"
      WORDCHARS=''${WORDCHARS//\//}
      WORDCHARS=''${WORDCHARS//-}
      WORDCHARS=''${WORDCHARS//.}
      WORDCHARS=''${WORDCHARS//\\}
    '';
  };
}

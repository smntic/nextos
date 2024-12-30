{ ... }:

{
  programs.zsh = {
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-autosuggestions"
        "romkatv/powerlevel10k"
      ];
    };
  };
}

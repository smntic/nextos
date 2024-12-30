{ ... }:

{
  programs.zsh = {
    autosuggestion.enable = true;

    history = {
      append = true;
      extended = true;
      ignoreDups = true;
    };

    defaultKeymap = "emacs";
  };
}

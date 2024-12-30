{ ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    theme = {
      status = {
        # I don't like the default pills
        separator_open = "";
        separator_close = "";
      };
    };
  };
}

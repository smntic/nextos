{ ... }@args:

{
  imports = [
    ./nvim/lua_config.nix
  ];

  programs.neovim = {
    enable = true;

    # Set nvim as the default editor and replace vim
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}

{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      which-key-nvim
    ];

    homeModules.nvim.lua = [
      ''
        local which_key = require('which-key')
        which_key.add({
          { '<leader>g', group = 'Git', icon = ' ' },
          { '<leader>f', group = 'Find', icon = '󰈞 ' },
          { '<leader>h', group = 'Harpoon', icon = '󰛢 ' },
          { '<leader>l', group = 'LSP', icon = '󰌵 ' },
          { '<leader>n', group = 'Neovim', icon = ' ' },
          { '<leader>t', group = 'VimTeX', icon = ' ' },
        })
      ''
    ];
  };
}

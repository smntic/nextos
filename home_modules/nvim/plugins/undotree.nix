{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      undotree
    ];

    homeModules.nvim.lua = [
      ''
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree | Toggle', silent = true })
      ''
    ];
  };
}

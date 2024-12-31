{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      vim-fugitive
    ];

    homeModules.nvim.lua = [
      ''
        vim.keymap.set('n', '<leader>gg', '<cmd>Git<CR>', { desc = 'Git | Open window', silent = true })
        vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<CR>', { desc = 'Git | Commit', silent = true })
        vim.keymap.set('n', '<leader>gr', '<cmd>Git rebase -i<CR>', { desc = 'Git | Interactive rebase', silent = true })
        vim.keymap.set('n', '<leader>gd', '<cmd>Git diff<CR>', { desc = 'Git diff', silent = true })
        vim.keymap.set('n', '<leader>gl', '<cmd>Git log<CR>', { desc = 'Git | Log', silent = true })
        vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = 'Git | Blame', silent = true })
      ''
    ];
  };
}

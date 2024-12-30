{ pkgs, config, ... }:

{
  config = {
    home.packages = [
      pkgs.ripgrep
    ];

    programs.neovim.plugins = with pkgs.vimPlugins; [
      telescope-nvim
    ];

    lua = [
      ''
        local telescope_builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope | Find files', silent = true })
        vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope | Live grep', silent = true })
        vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope | Buffers', silent = true })
        vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope | Help tags', silent = true })
      
        local telescope = require('telescope')
        local telescope_actions = require('telescope.actions')
        telescope.setup {
          defaults = {
            mappings = {
              i = {
                ['<C-k>'] = telescope_actions.move_selection_previous,
                ['<C-j>'] = telescope_actions.move_selection_next,
              }
            }
          }
        }
      ''
    ];
  };
}

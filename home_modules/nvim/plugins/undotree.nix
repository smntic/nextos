{ pkgs, config, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      undotree
    ];
    
    lua = [
      ''
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree | Toggle', silent = true })
      ''
    ];
  };
}

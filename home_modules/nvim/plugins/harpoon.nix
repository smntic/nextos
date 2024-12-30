{ pkgs, config, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      harpoon2
    ];
  
    lua = [
      ''
        local harpoon = require('harpoon')
        harpoon:setup()
        vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon | Add', silent = true })
        vim.keymap.set('n', '<leader>hm', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon | Menu', silent = true })
      
        for i = 1, 9 do
          vim.keymap.set('n', '<A-' .. tostring(i) .. '>', function() harpoon:list():select(11 - i) end, { desc = 'Harpoon | Goto ' .. tostring(11 - i), silent = true })
        end
        vim.keymap.set('n', '<A-0>', function() harpoon:list():select(1) end, { desc = 'Harpoon | Goto 1', silent = true })
      ''
    ];
  };
}

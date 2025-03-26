{ pkgs, ... }:

{ 
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      markdown-preview-nvim
    ];

    homeModules.nvim.lua = [
      ''
        vim.keymap.set('n', '<leader>M', vim.cmd.MarkdownPreviewToggle, { desc = 'MarkdownPreview | Toggle', silent = true })
      ''
    ];
  };
}

{ pkgs, config, ... }:

{ 
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      markdown-preview-nvim
    ];

    lua = [
      ''
        vim.keymap.set('n', '<leader>m', vim.cmd.MarkdownPreviewToggle, { desc = 'MarkdownPreview | Toggle', silent = true })
      ''
    ];
  };
}


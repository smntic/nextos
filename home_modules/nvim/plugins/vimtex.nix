{ pkgs, ... }:

{
  config = {
    home.packages = [
      pkgs.texlive.combined.scheme-full
      pkgs.zathura
    ];

    programs.neovim.plugins = with pkgs.vimPlugins; [
      vimtex
    ];

    homeModules.nvim.lua = [ 
      ''
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_latexmk = {
          out_dir = 'build'
        }
        vim.keymap.set('n', '<leader>tc', '<cmd>VimtexCompile<CR>', { desc = 'VimTeX | Compile', silent = true })
        vim.keymap.set('n', '<leader>tv', '<cmd>VimtexView<CR>', { desc = 'VimTeX | View', silent = true })
      ''
    ];
  };
}

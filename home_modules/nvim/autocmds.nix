{ ... }:

{
  config.homeModules.nvim.lua = [
    ''
      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

      autocmd("BufReadPost", {
        callback = function()
          if vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
            vim.cmd 'normal! g`"'
          end
        end,
        group = general,
        desc = "Go To The Last Cursor Position",
      })
    ''
  ];
}

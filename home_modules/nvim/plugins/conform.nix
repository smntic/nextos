{ pkgs, ... }:

{
  config = {
    home.packages = [
      pkgs.black
      pkgs.clang-tools
      pkgs.stylua
    ];

    programs.neovim.plugins = with pkgs.vimPlugins; [
      conform-nvim
    ];

    homeModules.nvim.lua = [
      ''
        local formatters = {
          lua = { "stylua" },
          python = { "black" },
          cpp = { "clang_format" },
          c = { "clang_format" },
        }

        local prettier_ft = {
          "css",
          "html",
          "json",
          "javascriptreact",
          "javascript",
          "markdown",
          "typescript",
          "typescriptreact",
        }

        for _, filetype in pairs(prettier_ft) do
          formatters[filetype] = { "prettier" }
        end

        local conform = require('conform')
        conform.setup {
          formatters_by_ft = formatters,
        }
      ''
    ];
  };
}

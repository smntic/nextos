{ pkgs, ... }:

{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      marks-nvim
    ];

    homeModules.nvim.lua = [ 
      ''
        local marks = require('marks')
        marks.setup {
          -- whether to map keybinds or not. default true
          default_mappings = true,

          -- which builtin marks to show. default {}
          builtin_marks = { ".", "<", ">", "^" },

          -- whether movements cycle back to the beginning/end of buffer. default true
          cyclic = true,

          -- whether the shada file is updated after modifying uppercase marks. default false
          force_write_shada = false,

          -- how often (in ms) to redraw signs/recompute mark positions. 
          -- higher values will have better performance but may cause visual lag, 
          -- while lower values may cause performance penalties. default 150.
          refresh_interval = 150,
        }
      ''
    ];
  };
}

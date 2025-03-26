{ lib, config, ... }@args:

let
  pluginFiles = import ./plugins.nix args;
  otherFiles = [ ./options.nix ./mappings.nix ./make.nix ./autocmds.nix ];
  allFiles = pluginFiles ++ otherFiles;
  first = import ./first.nix args;
in
  {
    imports = allFiles;

    options = {
      homeModules.nvim.lua = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "The list of lua \"pseudo-files\" to add to the neovim init.lua";
      };
    };

    config = {
      programs.neovim.extraLuaConfig = let
        luaMap =
          curLua:
            ''
              do
            '' +
            curLua +
            ''
              end
            '';
        luaConfig = lib.strings.concatMapStrings luaMap config.homeModules.nvim.lua;
      in
        first + luaConfig;
    };
  }


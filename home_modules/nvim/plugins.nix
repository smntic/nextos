{ root, ... }:

# Returns a list of all plugin file names
let
  file = import "${root}/lib/helpers/file.nix";
in
  file.listForFile ./plugins (pluginFile: builtins.toString ./plugins/${pluginFile})

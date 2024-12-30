{ root, ... }:

let
  file = import "${root}/lib/helpers/file.nix";
in
  file.listForFile ./plugins (pluginFile: ./plugins/${pluginFile})

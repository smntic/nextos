rec {
  listForFile = directory: fileFunction:
    let
      dirString = builtins.toString directory;
      sources = builtins.readDir dirString;
      sourceNames = builtins.attrNames sources;
    in
      builtins.map fileFunction sourceNames;

  setForFile = directory: fileFunction:
      builtins.listToAttrs (listForFile directory fileFunction);
}

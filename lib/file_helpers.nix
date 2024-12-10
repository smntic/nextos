{
  forFile = directory: fileFunction:
    let
      dirString = builtins.toString directory;
      sources = builtins.readDir dirString;
      sourceNames = builtins.attrNames sources;
    in
      builtins.listToAttrs (builtins.map fileFunction sourceNames);
}

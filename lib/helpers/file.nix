rec {
  # For each file in the directory, map the file name to a list value using the function
  listForFile = directory: fileFunction:
    let
      dirString = builtins.toString directory;
      sources = builtins.readDir dirString;
      sourceNames = builtins.attrNames sources;
    in
      builtins.map fileFunction sourceNames;

  # Given that listForFile returns a list of attribute sets with keys `name` and `value`
  # this function creates one attribute set with all the `name = value` set mappings
  setForFile = directory: fileFunction:
    builtins.listToAttrs (listForFile directory fileFunction);

  # Returns regex matches in the file's contents
  matchInFile = fileName: regex:
    builtins.match regex (builtins.readFile fileName);
}

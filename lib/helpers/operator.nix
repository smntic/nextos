{ lib, ... }:

{
  ternary = condition: ifBody: elseBody: lib.mkMerge [
    (lib.mkIf condition ifBody)
    (lib.mkIf (!condition) elseBody)
  ];
}

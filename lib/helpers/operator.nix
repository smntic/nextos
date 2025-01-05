{ lib, ... }:

{
  # If the condition evaluates to true, returns `ifBody`; otherwise, returns `elseBody`.
  # ternary = condition: ifBody: elseBody: lib.mkMerge [
  #   (lib.mkIf condition ifBody)
  #   (lib.mkIf (!condition) elseBody)
  # ];

  ternary = condition: ifBody: elseBody:
    if condition then ifBody else elseBody;
}

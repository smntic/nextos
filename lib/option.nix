{ lib, ... }:

{
  # Same as lib.mkEnableOption but with default value of true
  mkDisableOption = name: lib.mkEnableOption name // { default = true; };
}

{ lib, ... }:

{
  mkDisableOption = name: lib.mkEnableOption name // { default = true; };
}

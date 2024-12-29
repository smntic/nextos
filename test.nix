(import ./lib/helpers/file.nix).matchInFile "/etc/nixos/hosts/x13/hardware-configuration.nix" ".*nixpkgs\\.hostPlatform = lib.mkDefault \"([^\"]*)\".*"

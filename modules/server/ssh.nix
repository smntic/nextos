{ lib, config, root, ... }:

let
  operator = import "${root}/lib/helpers/operator.nix" { inherit lib; };
  moreOptions = import "${root}/lib/option.nix" { inherit lib; };
in
  {
    options = {
      ssh.server = moreOptions.mkDisableOption "the ssh service";
      ssh.allowPassword = lib.mkEnableOption "password authentication";
      ssh.allowRoot = lib.mkEnableOption "root login";
    };
  
    config.services.openssh = {
      enable = config.ssh.server;
  
      settings = {
        PasswordAuthentication = config.ssh.allowPassword;
        KbdInteractiveAuthentication = config.ssh.allowPassword;
	PermitRootLogin = operator.ternary config.ssh.allowRoot "yes" "no";
      };
    };
  }

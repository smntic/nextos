{ lib, config, root, ... }:

let
  operator = import "${root}/lib/helpers/operator.nix" { inherit lib; };
  option = import "${root}/lib/option.nix" { inherit lib; };
in
  {
    options = {
      modules.ssh.enable = option.mkDisableOption "ssh";
      modules.ssh.allowPassword = lib.mkEnableOption "password authentication";
      modules.ssh.allowRoot = lib.mkEnableOption "root login";
    };

    config = lib.mkIf config.modules.ssh.enable {
      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = config.modules.ssh.allowPassword;
          KbdInteractiveAuthentication = config.modules.ssh.allowPassword;
          PermitRootLogin = operator.ternary config.modules.ssh.allowRoot "yes" "no";
        };
      };
    };
  }

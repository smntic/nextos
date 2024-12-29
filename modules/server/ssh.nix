{ lib, config, root, ... }:

let
  operator = import "${root}/lib/helpers/operator.nix" { inherit lib; };
in
{
  options = {
    ssh.enable = lib.mkEnableOption "ssh";
    ssh.allowPassword = lib.mkEnableOption "password authentication";
    ssh.allowRoot = lib.mkEnableOption "root login";
  };

  config = lib.mkIf config.ssh.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = config.ssh.allowPassword;
        KbdInteractiveAuthentication = config.ssh.allowPassword;
        PermitRootLogin = operator.ternary config.ssh.allowRoot "yes" "no";
      };
    };
  };
}

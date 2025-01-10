{ lib, config, ... }:

{
  options = {
    modules.kdeconnect.enable = lib.mkEnableOption "kdeconnect";
  };

  config = lib.mkIf config.modules.kdeconnect.enable {
    programs.kdeconnect.enable = true;

    # https://www.reddit.com/r/NixOS/comments/xz4m6m/how_to_use_kdeconnect_on_nixos/
    networking.firewall = { 
      enable = true;
      allowedTCPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
      ];  
      allowedUDPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
      ];  
    };
  };
}

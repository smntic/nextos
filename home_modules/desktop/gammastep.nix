{ ... }:

{
  services.gammastep = {
    enable = true;

    # Approximately Vancouver
    provider = "manual";
    latitude = 49.3;
    longitude = -123.1;
    
    temperature = {
      day = 5500;
      night = 3000;
    };
    
    # Specify the times to align with my sleep "schedule"
    dawnTime = "6:00-7:00";
    duskTime = "21:00-22:00";
  };
}

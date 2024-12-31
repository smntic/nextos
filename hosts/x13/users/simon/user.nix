{ ... }:

{
  users.users.simon = {
    # https://xkcd.com/936/
    initialPassword = "correctHorseBatteryStaple";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}

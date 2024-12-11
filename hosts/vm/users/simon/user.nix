{ ... }:

{
  users.users.simon = {
    initialPassword = "correctHorseBatteryStaple";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}

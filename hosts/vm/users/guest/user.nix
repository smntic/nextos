{ ... }:

{
  users.users.guest = {
    initialPassword = "guest";
    isNormalUser = true;
    extraGroups = [];
  };
}

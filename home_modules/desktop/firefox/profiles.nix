{ ... }:

{
  programs.firefox.profiles.default = {
    id = 0;
    name = "default";
    isDefault = true;
    settings = {
      "browser.startup.homepage" = "about:newtab";
    };
  };
}

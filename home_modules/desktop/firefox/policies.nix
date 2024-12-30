{ ... }:

{
  programs.firefox.policies = {
    AppAutoUpdate = false;
    BackgroundAppUpdate = false;
    DisableFirefoxAccounts = true;
    DisableFirefoxStudies = true;
    DisableHardwareAcceleration = true;
    DisableSetDesktopBackground = true;
    DisablePrivateBrowsing = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFormHistory = true;
    DisablePasswordReveal = true;
    DisplayBookmarksToolbar = "never";
    DontCheckDefaultBrowser = true;
    ExtensionUpdate = false;
    FirefoxSuggest = false;
    OfferToSaveLogins = false;
    SearchSuggestEnabled = false;
  };
}

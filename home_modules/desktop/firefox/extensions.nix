{ ... }:

{
  programs.firefox.policies.ExtensionSettings = let
    extension = shortId: uuid: {
      name = uuid;
      value = {
        install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
        installation_mode = "normal_installed";
      };
    };
  in
    # Find the shortId in the URL. e.g. https://addons.mozilla.org/en-CA/firefox/addon/<shortId>/
    # Find the uuid at about:debugging#/runtime/this-firefox AFTER installing the extension (temporarily imperatively)
    builtins.listToAttrs [
      (extension "ublock-origin" "uBlock0@raymondhill.net")
      (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
      (extension "darkreader" "addon@darkreader.org")
      (extension "600-sound-volume" "{c4b582ec-4343-438c-bda2-2f691c16c262}")
      (extension "youtube-recommended-videos" "myallychou@gmail.com")
      (extension "detach-tab" "claymont@mail.com_detach-tab")
    ];
}

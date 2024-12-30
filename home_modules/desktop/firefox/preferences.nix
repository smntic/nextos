{ ... }:

let
  lock = value: {
    Value = value;
    Status = "locked";
  };
in
  {
    programs.firefox.policies.Preferences = {
      "browser.urlbar.suggest.topsites" = lock false;
      "browser.topsites.contile.enabled" = lock false;
      "browser.newtabpage.activity-stream.feeds.snippets" = lock false;
      "browser.newtabpage.activity-stream.feeds.topsites" = lock false;
      "browser.newtabpage.activity-stream.showSponsored" = lock false;
      "browser.newtabpage.activity-stream.system.showSponsored" = lock false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock false;
      "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = lock false;
      "browser.uiCustomization.state" = lock "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"ublock0_raymondhill_net-browser-action\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"unified-extensions-area\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":20,\"newElementCount\":2}";
    };
  }

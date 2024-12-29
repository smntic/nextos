{ config, ... }:

{
  xdg = {
    # Maybe in the future...
    # mimeApps = {
    #   enable = true;
    # };

    userDirs = {
      enable = true;
      createDirectories = true;

      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/publicShare";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";

      extraConfig = {
        XDG_GIT_DIR = "${config.home.homeDirectory}/git";
      };
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "image/gif" = "sxiv.desktop";
        "image/jpeg" = "sxiv.desktop";
        "image/png" = "sxiv.desktop";
        "image/webp" = "sxiv.desktop";
      };
    };
  };
}

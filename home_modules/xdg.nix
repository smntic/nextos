{ lib, config, ... }:

{
  options = {
    homeModules.xdg = {
      userDirs = {
        enable = lib.mkEnableOption "user directory management with XDG";
        directories = lib.mkOption {
          type = lib.types.attrs;
          description = "Paths for each XDG directory.";
          example = "{ desktop = \"\${config.home.homeDirectory}/desktop}";
          default = {};
        };
        extraDirectories = lib.mkOption {
          type = lib.types.attrs;
          description = "Paths for each additional directory, with environment variable names.";
          example = "{ XDG_GIT_DIR = \"\${config.home.homeDirectory}/git}";
          default = {};
        };
      };

      mimeApps = {
        enable = lib.mkEnableOption "MIME app management with XDG";
        defaultApplications = let
          defaultOption = lib.mkOption {
            type = lib.types.str;
            description = "Default application to open files of this type.";
            example = "kate.desktop";
          };
        in
          {
            image = defaultOption;
          };
      };
    };
  };

  config = {
    xdg = {
      userDirs = config.homeModules.xdg.userDirs.directories // {
        enable = config.homeModules.xdg.userDirs.enable;
        createDirectories = true;
        extraConfig = config.homeModules.xdg.userDirs.extraDirectories;
      };

      mimeApps = lib.mkIf config.homeModules.xdg.mimeApps.enable {
        enable = true;

        defaultApplications = {
          "image/gif" = config.homeModules.xdg.mimeApps.defaultApplications.image;
          "image/jpeg" = config.homeModules.xdg.mimeApps.defaultApplications.image;
          "image/png" = config.homeModules.xdg.mimeApps.defaultApplications.image;
          "image/webp" = config.homeModules.xdg.mimeApps.defaultApplications.image;
        };
      };
    };
  };
}

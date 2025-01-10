{ config, ... }:

{
  xsession.windowManager.i3.config.bars = [
    {
      position = "top";
      statusCommand = "i3status";
      trayOutput = null;

      fonts = {
        names = [ "monospace" ];
        size = "${builtins.toString config.stylix.fonts.sizes.desktop}";
      };

      colors = {
        activeWorkspace = rec {
          background = "#${config.lib.stylix.colors.base03}40";
          border = background;
          text = "#${config.lib.stylix.colors.base05}";
        };

        focusedWorkspace = {
          background = "#${config.lib.stylix.colors.base03}A0";
          border = "#${config.lib.stylix.colors.base03}E0";
          text = "#${config.lib.stylix.colors.base05}";
        };

        inactiveWorkspace = rec {
          background = "#${config.lib.stylix.colors.base03}40";
          border = background;
          text = "#${config.lib.stylix.colors.base05}";
        };

        urgentWorkspace = rec {
          background = "#${config.lib.stylix.colors.base08}40";
          border = background;
          text = "#${config.lib.stylix.colors.base05}";
        };

        background = "#${config.lib.stylix.colors.base00}80";
        bindingMode = {
          background = "#00000000";
          border = "#${config.lib.stylix.colors.base08}";
          text = "#${config.lib.stylix.colors.base05}";
        };

        separator = "#${config.lib.stylix.colors.base03}";
        statusline = "#${config.lib.stylix.colors.base05}";
      };

      extraConfig = ''
        i3bar_command i3bar --transparency
      '';
    }
  ];
}


{ config, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in
  {
    programs.rofi.theme = {
      "*" = {
        width = 512;
      };
    
      window = {
        border = mkLiteral "1px";
        border-color = mkLiteral config.lib.stylix.colors.withHashtag.base0D;
      };
    
      inputbar = {
        padding = mkLiteral "5px";
        spacing = mkLiteral "5px";
      };
    
      prompt = {
        font = "monospace 14px";
      };
    
      entry = {
        font = "monospace 14px";
      };
    
      listview = {
        lines = 10;
      };
    
      element = {
        padding = mkLiteral "5px";
        spacing = mkLiteral "10px";
      };
    
      element-text = {
        font = "monospace 14px";
      };
    };
  }

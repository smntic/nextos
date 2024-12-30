{ ... }:

{
  programs.waybar.style = ''
    * {
      font-family: 'monospace';
    }
    
    #workspaces button {
      padding: 0 0.5em;
      border-radius: 0;
    }
    
    #workspaces button:hover {
      background: alpha(@base05, 0.2);
    }
    
    #workspaces button.active {
      background: alpha(@base05, 0.1);
    }
    
    #workspaces button.active:hover {
      background: alpha(@base05, 0.2);
    }
    
    #workspaces button.urgent {
      background: alpha(@base08, 0.3);
    }
    
    .modules-right label.module {
      margin-right: 0.5em;
    }
    
    #network.wifi, #network.linked, #network.ethernet {
      color: @base0B;
    }
    
    #network.disabled, #network.disconnected {
      color: @base08;
    }
    
    #wireplumber.muted {
      color: @base09;
    }
    
    #custom-separator {
      color: @base04;
    }
  '';
}

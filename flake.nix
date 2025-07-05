{
  description = "nextOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";

      # Reduce disk usage
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    # Stylix (temporarily switching to my fork for KDE/QT support)
    # stylix.url = "github:smntic/stylix";
    stylix.url = "github:nix-community/stylix/release-25.05";

    # cp-tool (my own competitive programming tool)
    cp-tool.url = "github:smntic/cp-tool";

    nix-inspect.url = "github:bluskript/nix-inspect";

    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvim plugin blink (nixpkgs version is *very* outdated)
    blink = {
      url = "github:Saghen/blink.cmp";
    };

    # nixpkgs version doesn't work with keymaps.toml... who knows why. yes i did spend an hour debugging this.
    yazi = {
      url = "github:sxyazi/yazi";
    };
  };

  outputs = { self, nixpkgs, home-manager, kmonad, ... }@inputs:
    let
      file = import ./lib/helpers/file.nix;
    in
      {
        # Create a nixos configuration for each host
        nixosConfigurations = file.setForFile ./hosts (hostName:
          {
            name = hostName;
            value = let
              # Extract the system platform from the hardware configuration file
              hardwareFile = ./hosts/${hostName}/hardware-configuration.nix;
              systemRegex = ".*nixpkgs\\.hostPlatform = lib.mkDefault \"([^\"]*)\".*";
              system = builtins.elemAt (file.matchInFile hardwareFile systemRegex) 0;

              # Use nixpkgs with unfree software (requires system platform)
              pkgs = import nixpkgs {
                system = system;
                config = {
                  allowUnfree = true;
                  permittedInsecurePackages = [
                    "dotnet-sdk-6.0.428"
                  ];
                };
                overlays = [
                  (import ./overlays/linux-firmware.nix)
                ];
              };
            in
              nixpkgs.lib.nixosSystem rec {
                # Arguments passed to every file (unless imported directly)
                specialArgs = {
                  inherit inputs;
                  pkgs = pkgs;
                  root = self;
                  hostRoot = ./hosts/${hostName};
                };

                modules = [
                  # From evaluation warning about overriding nixpkgs
                  "${nixpkgs}/nixos/modules/misc/nixpkgs/read-only.nix"

                  # Include the configuration.nix and hardware-configuration.nix for each host
                  ./core/configuration.nix
                  ./hosts/${hostName}/configuration.nix
                  hardwareFile
                  
                  home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = specialArgs;
                    
                    # Include the home.nix file for each user
                    home-manager.users = file.setForFile ./hosts/${hostName}/users (userName:
                      {
                        name = userName;
                        value = {
                          imports = [
                            ./core/home.nix
                            ./hosts/${hostName}/users/${userName}/home.nix
                          ];
                        };
                      }
                    );
                  }
                ]
                # Include the user.nix file for each user of this host
                ++ file.listForFile ./hosts/${hostName}/users (userName:
                  ./hosts/${hostName}/users/${userName}/user.nix);

                # (Doesn't) Suppress warning about overriding nixpkgs (i don't know how to do this)
                # nixpkgs.pkgs = pkgs;
              };
          });
      };
}

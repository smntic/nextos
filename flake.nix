{
  description = "A very basic flake";

  inputs = {
    # Nix & Home Manager
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktops
    hyprland.url = "github:hyprwm/Hyprland";

    # Stylix (temporarily switching to my fork for KDE/QT support)
    stylix.url = "github:smnast/stylix";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      file = import ./lib/helpers/file.nix;
    in
      {
        nixosConfigurations = file.setForFile ./hosts (hostName:
	  {
            name = hostName;
            value = let
              hardwareFile = ./hosts/${hostName}/hardware-configuration.nix;
              systemRegex = ".*nixpkgs\\.hostPlatform = lib.mkDefault \"([^\"]*)\".*";
	      system = builtins.elemAt (file.matchInFile hardwareFile systemRegex) 0;
	      pkgs = import nixpkgs {
                system = system;
		config.allowUnfree = true;
	      };
            in
	      nixpkgs.lib.nixosSystem rec {
                specialArgs = {
	          inherit inputs;
	          pkgs = pkgs;
	          root = self;
		  hostRoot = ./hosts/${hostName};
	        };
                modules = [
	          ./core/configuration.nix
	          ./hosts/${hostName}/configuration.nix
                  
                  home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
		    home-manager.extraSpecialArgs = specialArgs;

		    home-manager.users = file.setForFile ./hosts/${hostName}/users (userName:
		      {
                        name = userName;
			value = import ./hosts/${hostName}/users/${userName}/home.nix;
		      }
		    );
		  }
	        ] ++ file.listForFile ./hosts/${hostName}/users (userName:
	            ./hosts/${hostName}/users/${userName}/user.nix);
              };
	  });
      };
}

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

    # Stylix
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      file = import ./lib/helpers/file.nix;
    in
      {
        nixosConfigurations = file.setForFile ./hosts (hostName:
	  {
            name = hostName;
            value = nixpkgs.lib.nixosSystem {
              specialArgs = {
	        inherit inputs;
		root = self;
	      };
              modules = [
		./core/configuration.nix
	        ./hosts/${hostName}/configuration.nix
                
                home-manager.nixosModules.home-manager {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                }

	      ] ++ file.listForFile ./hosts/${hostName}/users (userName:
	          ./hosts/${hostName}/users/${userName}/user.nix);
            };
	  });
      };
}

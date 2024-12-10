{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      fileHelpers = import ./lib/file_helpers.nix;
    in
      {
        nixosConfigurations = fileHelpers.forFile ./hosts (hostName:
	  {
            name = hostName;
            value = nixpkgs.lib.nixosSystem {
              specialArgs = {
	        inherit inputs;
		root = self;
	      };
              modules = [
	        ./hosts/${hostName}/configuration.nix
      
                home-manager.nixosModules.home-manager {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
		  home-manager.users = fileHelpers.forFile ./hosts/${hostName}/users (userName:
		    {
		      name = userName;
		      value = import ./hosts/${hostName}/users/${userName}/home.nix;
		    });
                }
	      ];
            };
	  });
      };
}

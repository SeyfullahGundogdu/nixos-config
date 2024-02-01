{
    description = "SeyfullahConfig";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        home-manager.url = "github:nix-community/home-manager/release-23.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        minegrub-theme = {
            url = "github:Lxtharia/minegrub-theme";
        };
    };
  
    outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
        system = "x86_64-linux";

        # User Variables
        hostname = "nixos";
        username = "bake";
        gitUsername = "Seyfullah Gündoğdu";
        gitEmail = "seyfullahgundogdu74@gmail.com";
        theLocale = "en_GB.UTF-8";
        theKBDLayout = "en";
        theLCVariables = "en_GB.UTF-8";
        theTimezone = "Europe/Istanbul";
        browser = "firefox";
        flakeDir = "/home/${username}/.config/home-manager";
        pkgs = import nixpkgs {
            inherit system;
            config = {
                allowUnfree = true;
            };
        };
    in {
        nixosConfigurations = {
            "${hostname}" = nixpkgs.lib.nixosSystem {
                specialArgs = { 
                    inherit system;
                    inherit inputs; 
                    inherit username;
                    inherit hostname;
                    inherit theTimezone;
                    inherit theLocale;
                    inherit theKBDLayout;
                    inherit theLCVariables;
                };
                modules = [ 
                    ./system/configuration.nix
                    inputs.minegrub-theme.nixosModules.default
                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = { 
                            inherit username; 
                            inherit gitUsername; 
                            inherit gitEmail;
                            inherit inputs; 
                            inherit browser;
                            inherit flakeDir;
                        };
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.${username} = import ./user/${username}/${username}.nix;
                    }
                ];
            };
        };
    };
}

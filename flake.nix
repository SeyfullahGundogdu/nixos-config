{
  description = "SeyfullahConfig";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    plasma-manager,
    spicetify-nix,
	disko,
    ...
  }: let
    # User Variables
    hostname = "kurohitsugi";
    username = "bake";
    gitUsername = "Seyfullah Gündoğdu";
    gitEmail = "seyfullahgundogdu74@gmail.com";
    theLocale = "en_GB.UTF-8";
    theLCVariables = "en_GB.UTF-8";
    theTimezone = "Europe/Istanbul";
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit hostname;
          inherit theTimezone;
          inherit theLocale;
          inherit theLCVariables;
        };
        modules = [
          ./system
        disko.nixosModules.disko
        ./disko.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit username;
              inherit gitUsername;
              inherit gitEmail;
              inherit inputs;
              inherit plasma-manager;
              inherit hostname;
              inherit spicetify-nix;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/${username};
          }
        ];
      };
    };

  };
}

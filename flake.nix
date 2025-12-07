{
  description = "SeyfullahConfig";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    spicetify-nix,
    disko,
    ...
  }: let
    # User Variables
    hostname = "kurohitsugi";
    username = "cake";
    gitUsername = "Seyfullah Gundogdu";
    gitEmail = "seyfullahgundogdu74@gmail.com";
    theLocale = "en_US.UTF-8";
    theLCVariables = "en_US.UTF-8";
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
          inputs.spicetify-nix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit username;
              inherit gitUsername;
              inherit gitEmail;
              inherit inputs;
              inherit hostname;
              inherit spicetify-nix;
            };
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.users.${username} = import ./home/${username};
          }
        ];
      };
    };
  };
}

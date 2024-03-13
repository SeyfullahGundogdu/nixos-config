{
  description = "SeyfullahConfig";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    tuxedo-nixos = {
      url = "github:blitz/tuxedo-nixos";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    plasma-manager,
    tuxedo-nixos,
    ...
  }: let
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
          ./system
          tuxedo-nixos.nixosModules.default
          {
            hardware.tuxedo-control-center.enable = true;
            hardware.tuxedo-control-center.package = tuxedo-nixos.packages.x86_64-linux.default;
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit username;
              inherit gitUsername;
              inherit gitEmail;
              inherit inputs;
              inherit plasma-manager;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./user/${username};
          }
        ];
      };
    };
  };
}

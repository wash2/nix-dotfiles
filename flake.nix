{
  description = "Ashley's System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    cosmic-comp.url = "github:pop-os/cosmic-comp/master_jammy";
    cosmic-comp.inputs.nixpkgs.follows = "nixpkgs";
    cosmic-session.url = "github:pop-os/cosmic-session/0201b14c803c3e20c385da9e3e41b18e4ef55824";
    cosmic-session.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, cosmic-comp, cosmic-session }@attrs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in { 
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs.inputs = attrs;
        modules = [
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ashley = import ./users/ashley/home.nix;
          }
        ];
      };
    };
  };
}

{
  description = "Ashley's System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    cosmic-comp.url = "github:pop-os/cosmic-comp/master_jammy";
    cosmic-panel.url = "github:pop-os/cosmic-panel/master_jammy";
    cosmic-settings.url = "github:pop-os/cosmic-settings/master_jammy";
    cosmic-settings-daemon.url = "github:pop-os/cosmic-settings-daemon/master_jammy";
    cosmic-launcher.url = "github:pop-os/cosmic-launcher/aad3e0b56f2a07dad0a7c3045c87045a01a49809";
    cosmic-applibrary.url = "github:pop-os/cosmic-applibrary/da5618ca25fe338573310b5afb29712c742a6b92";
    cosmic-session.url = "github:pop-os/cosmic-session/a5589ab6f4635a64cc5a3aa0d1dbe79169252c52";
    cosmic-applets.url = "github:pop-os/cosmic-applets/58c27e88603ad47479115b632d2fa87579d8fa39";
    cosmic-workspaces.url = "github:pop-os/cosmic-workspaces-epoch/717c454a7e31c4ffc8baf6c1d1c90fd74a223e55";
    cosmic-osd.url = "github:pop-os/cosmic-osd/b6d93f736d4b9ab3df4cceafaf59cd8c95859ed6";
    cosmic-bg.url = "github:pop-os/cosmic-bg/d64ade9e7164990b8bb2abc8a754ca16edcff652";
    xdg-desktop-portal-cosmic.url = "github:pop-os/xdg-desktop-portal-cosmic/master_jammy";
  };

  outputs = { self, nixpkgs, home-manager, cosmic-comp, cosmic-session, cosmic-panel, cosmic-applets, cosmic-settings, cosmic-settings-daemon, cosmic-launcher, cosmic-applibrary, cosmic-workspaces, cosmic-osd, xdg-desktop-portal-cosmic, cosmic-bg  }@attrs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    cosmic-session.inputs.nixpkgs.follows = "nixpkgs";

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

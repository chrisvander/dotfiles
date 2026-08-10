{
  description = "Chris's system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, home-manager, ... }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mbp
    darwinConfigurations.mbp = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        home-manager.darwinModules.home-manager
        ./modules/hosts/mbp.nix
      ];
    };
    # homeConfigurations."chris@pi" = home-manager.lib.homeManagerConfiguration {
    #   pkgs = nixpkgs.legacyPackages.aarch64-linux;

    #   modules = [
    #     ./modules/home/shell.nix
    #     ./modules/home/roles/personal.nix
    #   ];
    # };
  };
}

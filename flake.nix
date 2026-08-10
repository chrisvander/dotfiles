{
  description = "Chris's system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        with pkgs; [
          vim
          nil
          nixd
        ];

      homebrew = {};

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Fish shell setup
      programs.fish.enable = true;
      environment.shells = [ pkgs.fish ];
      users.users.chrisvanderloo = {
        home = "/Users/chrisvanderloo";
        shell = pkgs.fish;
      };

      # Enable Touch ID authentication for sudo
      security.pam.services.sudo_local.touchIdAuth = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Chriss-MacBook-Pro-14
    darwinConfigurations."Chriss-MacBook-Pro-14" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
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

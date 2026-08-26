{
  description = "Reusable system and user configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      dotfilesLib = import ./lib {
        inherit (inputs)
          home-manager
          nix-darwin
          nix-homebrew
          nixpkgs
          nixpkgs-unstable
          ;
      };

      homeManagerModules = {
        base = ./modules/home/base.nix;
        cloud = ./modules/home/cloud.nix;
        fish = ./modules/home/fish.nix;
        ghostty = ./modules/home/ghostty.nix;
        helix = ./modules/home/helix.nix;
        kubernetes = ./modules/home/kubernetes.nix;
        podman = ./modules/home/podman.nix;
      };

      languageModules = {
        astro = ./modules/languages/astro.nix;
        cpp = ./modules/languages/cpp.nix;
        csharp = ./modules/languages/csharp.nix;
        nix = ./modules/languages/nix.nix;
        python = ./modules/languages/python.nix;
        rust = ./modules/languages/rust.nix;
        typescript = ./modules/languages/typescript.nix;
      };

      darwinModules.homebrew = ./modules/darwin/homebrew.nix;

      exampleUser = {
        username = "example";
        homeDirectory = "/Users/example";
      };
      exampleVcs = {
        name = "Example User";
        email = "example@example.invalid";
      };
      exampleModules = builtins.attrValues homeManagerModules ++ builtins.attrValues languageModules;
    in
    {
      lib = dotfilesLib;
      inherit darwinModules homeManagerModules languageModules;

      checks.aarch64-darwin = {
        example =
          (dotfilesLib.mkDarwin {
            system = "aarch64-darwin";
            darwinStateVersion = 6;
            homeStateVersion = "26.05";
            user = exampleUser;
            vcs = exampleVcs;
            modules = exampleModules;
            darwinModules = [ darwinModules.homebrew ];
          }).system;
      };

      checks.aarch64-linux.example =
        (dotfilesLib.mkHome {
          system = "aarch64-linux";
          homeStateVersion = "26.05";
          user = {
            username = "example";
            homeDirectory = "/home/example";
          };
          vcs = exampleVcs;
          modules = [
            homeManagerModules.base
            homeManagerModules.fish
            homeManagerModules.helix
            languageModules.nix
          ];
        }).activationPackage;

      templates.darwin-host = {
        path = ./templates/darwin-host;
        description = "Local nix-darwin host using these dotfiles";
      };

      devShells.aarch64-darwin =
        let
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          # nixpkgs still exposes TypeScript 7 under its former package name.
          typescript = pkgs.typescript-go;
        in
        {
          rust = pkgs.mkShellNoCC {
            name = "rust";
            packages = with pkgs; [
              cargo
              clippy
              rust-analyzer
              rustc
              rustfmt
            ];
          };

          js = pkgs.mkShellNoCC {
            name = "js";
            packages = [
              pkgs.bun
              pkgs.nodejs_26
              pkgs.pnpm
              typescript
            ];
          };

          nix = pkgs.mkShellNoCC {
            name = "nix";
            packages = with pkgs; [
              nixd
              nixfmt
            ];
          };
        };
    };
}

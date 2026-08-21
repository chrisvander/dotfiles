{ nixpkgs-unstable, pkgs, ... }: {
  imports = [
    ../darwin
  ];

  networking.hostName = "Chriss-MacBook-Pro-14";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "before-home-manager";

    extraSpecialArgs = { inherit nixpkgs-unstable; };

    users.chrisvanderloo = {
      imports = [
        ../home/helix.nix
        ../home/fish.nix
        ../home/ghostty.nix
        ../home/packages.nix
        ../home/podman.nix
        ../home/kubernetes.nix
      ];

      home.packages = with pkgs; [
        kind

        # Rust
        cargo
        rustc
        rust-analyzer
        rustfmt
        clippy
      ];

      home.stateVersion = "26.05";
      xdg.enable = true;
      programs.home-manager.enable = true;
    };
  };
}

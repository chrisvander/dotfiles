{ nixpkgs-unstable, ... }: {
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
      ];

      home.stateVersion = "26.05";
      xdg.enable = true;
      programs.home-manager.enable = true;
    };
  };
}

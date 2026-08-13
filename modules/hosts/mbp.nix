{
  imports = [
    ../darwin
  ];

  networking.hostName = "Chriss-MacBook-Pro-14";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "before-home-manager";
    users.chrisvanderloo = {
      imports = [
        ../home/helix.nix
        ../home/fish.nix
        ../home/ghostty.nix
        ../home/bat.nix
        ../home/fzf.nix
        ../home/starship.nix
      ];

      home.stateVersion = "26.05";
      xdg.enable = true;
      programs.home-manager.enable = true;
    };
  };
}

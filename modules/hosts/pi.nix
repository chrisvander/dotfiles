{
  useGlobalPkgs = true;
  useUserPackages = true;
  backupFileExtension = "before-home-manager";
  users.chris = {
    imports = [
      ../home/fish.nix
      ../home/helix.nix
      ../home/packages.nix
    ];

    home.stateVersion = "26.05";
    xdg.enable = true;
    programs.home-manager.enable = true;
  };
}

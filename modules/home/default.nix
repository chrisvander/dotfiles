{
  imports = [
    ./helix.nix
    ./ghostty.nix
    ./bat.nix
    ./fzf.nix
    ./starship.nix
  ];

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}

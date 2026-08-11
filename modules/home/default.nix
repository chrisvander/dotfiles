{
  imports = [
    ./helix.nix
    ./fish.nix
    ./ghostty.nix
    ./bat.nix
    ./fzf.nix
    ./starship.nix
  ];

  home.stateVersion = "26.05";
  xdg.enable = true;
  programs.home-manager.enable = true;
}

{ pkgs, ... }: {
  imports = [
    ../home/fish.nix
    ../home/helix.nix
    ../home/packages.nix
  ];

  home = {
    username = "chris";
    homeDirectory = "/home/chris";
    stateVersion = "26.05";
  };

  nix = {
    package = pkgs.nix;
    settings = {
      cores = 2;
      max-jobs = 1;
      http-connections = 8;
    };
  };

  programs.fish.plugins = [
    {
      name = "nix-env";
      src = pkgs.fetchFromGitHub {
        owner = "lilyball";
        repo = "nix-env.fish";
        rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
        sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
      };
    }
  ];

  xdg.enable = true;
  programs.home-manager.enable = true;
}

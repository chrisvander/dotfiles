{ lib, pkgs, self, nixpkgs-unstable, ... }:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;

    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "1password-cli"
      ];
  };
in {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Fish shell setup
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  users.users.chrisvanderloo = {
    home = "/Users/chrisvanderloo";
    shell = pkgs.fish;
    packages = with pkgs; [
      # Shell packages
      dust
      gh
      git
      eza
      fzf
      zoxide

      # Kubernetes
      k9s
      kubectl
      kind

      # .NET
      dotnet-sdk_9

      pulumi

      llvm

      # Python
      uv
      python3

      azure-cli
      commitizen

      # Podman
      podman
      podman-compose


      # Node
      nodejs_26
      pnpm
      bun

      # Nix
      nil
      nixd
      # TailwindCSS
      tailwindcss-language-server
      # TS
      oxlint
      oxfmt
      typescript-go
      typescript-language-server
      # Astro
      astro-language-server
    ] ++ [
      unstable.jujutsu
      unstable._1password-cli
    ];
  };

   security.pam.services.sudo_local = {
    # Enable Touch ID authentication for sudo
    touchIdAuth = true;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}

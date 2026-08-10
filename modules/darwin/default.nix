{ pkgs, self, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ nil nixd ];

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
      bat
      gh
      git
      jujutsu
      eza
      fzf
      starship

      # LSPs
      # - Nix
      nil
      nixd
      # - TailwindCSS
      tailwindcss-language-server
      # - TS
      oxlint
      oxfmt
      typescript-go
      typescript-language-server
      # - Astro
      astro-language-server
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "before-home-manager";
    users.chrisvanderloo = import ../home;
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

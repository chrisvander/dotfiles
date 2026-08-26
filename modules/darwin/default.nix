{ host, pkgs, ... }: {
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Fish shell setup
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  users.users.${host.user.username} = {
    home = host.user.homeDirectory;
    shell = pkgs.fish;
  };

  system.primaryUser = host.user.username;
  system.defaults.menuExtraClock = {
    Show24Hour = false;
    ShowAMPM = true;
    ShowDate = 2;
    ShowDayOfMonth = false;
    ShowDayOfWeek = true;
    ShowSeconds = false;
  };
  system.defaults.dock = {
    tilesize = 64;
    magnification = true;
    largesize = 85;
  };

  security.pam.services.sudo_local = {
    # Enable Touch ID authentication for sudo
    touchIdAuth = true;
  };

  # Set Git commit hash for darwin-version.
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = host.darwinStateVersion;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = host.system;
}

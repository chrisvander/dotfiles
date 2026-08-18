{ pkgs, self, ... }: {
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Fish shell setup
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  users.users.chrisvanderloo = {
    home = "/Users/chrisvanderloo";
    shell = pkgs.fish;
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

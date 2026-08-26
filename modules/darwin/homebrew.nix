{ host, nixHomebrew, ... }: {
  imports = [ nixHomebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    enable = true;
    user = host.user.username;
    autoMigrate = true;
  };
}

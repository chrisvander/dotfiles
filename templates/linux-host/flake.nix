{
  description = "Local Linux or container home configuration";

  inputs.dotfiles.url = "github:chrisvander/dotfiles";

  outputs = { dotfiles, ... }: {
    homeConfigurations.default = dotfiles.lib.mkHome {
      system = "x86_64-linux";
      homeStateVersion = "26.05";

      user = {
        username = "example";
        homeDirectory = "/home/example";
      };

      vcs = {
        name = "Example User";
        email = "example@example.invalid";
      };

      modules =
        (with dotfiles.homeManagerModules; [
          fish
          helix
        ])
        ++ (with dotfiles.languageModules; [
          nix
        ]);
    };
  };
}

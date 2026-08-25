{
  description = "Local host configuration";

  inputs.dotfiles.url = "github:chrisvander/dotfiles";

  outputs = { self, dotfiles }: {
    darwinConfigurations.default = dotfiles.lib.mkDarwin {
      source = self;
      system = "aarch64-darwin";
      darwinStateVersion = 6;
      homeStateVersion = "26.05";

      user = {
        username = "example";
        homeDirectory = "/Users/example";
      };

      vcs = {
        name = "Example User";
        email = "example@example.invalid";
      };

      modules =
        with dotfiles.homeManagerModules;
        [
          base
          fish
          ghostty
          helix
        ]
        ++ (with dotfiles.languageModules; [
          nix
        ]);
    };
  };
}

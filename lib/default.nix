{
  home-manager,
  nix-darwin,
  nixpkgs,
  nixpkgs-unstable,
}:
let
  inherit (nixpkgs) lib;

  requireNonEmpty = field: value: if value == "" then throw "${field} must not be empty" else value;

  validateUser = { username, homeDirectory }: {
    username = requireNonEmpty "user.username" username;
    homeDirectory =
      if lib.hasPrefix "/" homeDirectory then
        homeDirectory
      else
        throw "user.homeDirectory must be an absolute path";
  };

  validateVcs =
    {
      name,
      email,
      jjBookmarkPrefix ? null,
    }:
    {
      name = requireNonEmpty "vcs.name" name;
      email = requireNonEmpty "vcs.email" email;
      inherit jjBookmarkPrefix;
    };
in
{
  mkDarwin =
    {
      system,
      hostName,
      darwinStateVersion,
      homeStateVersion,
      user,
      vcs,
      modules ? [ ],
      darwinModules ? [ ],
      source ? null,
    }:
    let
      host = {
        inherit system darwinStateVersion homeStateVersion;
        hostName = requireNonEmpty "hostName" hostName;
        user = validateUser user;
        vcs = validateVcs vcs;
      };
    in
    nix-darwin.lib.darwinSystem {
      specialArgs = { inherit host nixpkgs-unstable; };
      modules = [
        home-manager.darwinModules.home-manager
        ../modules/darwin
        ({ ... }: {
          networking.hostName = host.hostName;
          system.configurationRevision =
            if source == null then null else source.rev or source.dirtyRev or null;

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "before-home-manager";
            extraSpecialArgs = { inherit host nixpkgs-unstable; };

            users.${host.user.username} = {
              imports = modules;
              home.stateVersion = host.homeStateVersion;
              xdg.enable = true;
              programs.home-manager.enable = true;
            };
          };
        })
      ]
      ++ darwinModules;
    };

  mkHome =
    {
      system,
      homeStateVersion,
      user,
      vcs,
      modules ? [ ],
      extraModules ? [ ],
    }:
    let
      host = {
        inherit system homeStateVersion;
        user = validateUser user;
        vcs = validateVcs vcs;
      };
    in
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${host.system};
      extraSpecialArgs = { inherit host nixpkgs-unstable; };
      modules = [
        ({ ... }: {
          imports = modules;
          home = {
            inherit (host.user) username homeDirectory;
            stateVersion = host.homeStateVersion;
          };
          xdg.enable = true;
          programs.home-manager.enable = true;
        })
      ]
      ++ extraModules;
    };
}

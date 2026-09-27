# dotfiles

Reusable nix-darwin and Home Manager components. Real hostnames, user details,
home directories, and VCS identity belong in a separate local host flake.

Run `devenv shell` in this checkout for the Rust, JavaScript/TypeScript, and Nix
development tools.

The `fish` Home Manager module installs devenv from `nixpkgs-unstable` and uses its
native auto-activation hook. It keeps direnv available for editors such as Zed;
add `dotfiles.homeManagerModules.direnv` to enable direnv's Fish hook as well.

For a Linux host or an existing Docker container with Nix installed:

```sh
mkdir -p ~/dotfiles-host
cd ~/dotfiles-host
nix flake init -t github:chrisvander/dotfiles#linux-host
```

Edit the generated `flake.nix` to choose the architecture, user, and modules, then
build and activate as that user:

```sh
nix build .#homeConfigurations.default.activationPackage
./result/activate
```

See [the Linux template instructions](templates/linux-host/README.md) for container
setup details.

Create a local Darwin host without cloning this repository:

```sh
mkdir -p ~/Developer/dotfiles-host
cd ~/Developer/dotfiles-host
nix flake init -t github:chrisvander/dotfiles#darwin-host
```

The generated `flake.nix` selects modules from `homeManagerModules` and
language-specific toolchains and LSPs from `languageModules`.

It also selects `darwinModules.homebrew`, which installs Homebrew itself. Add
formulae and casks separately if you want them declaratively managed.

Build it with the published dotfiles revision:

```sh
darwin-rebuild build --flake ~/Developer/dotfiles-host#default
```

While editing a local dotfiles checkout, override the published input:

```sh
darwin-rebuild build \
  --flake ~/Developer/dotfiles-host#default \
  --override-input dotfiles path:$PWD
```

To install the skills in `config/codex/skills` and global Codex instructions from
`config/codex/AGENTS.md`, add
`dotfiles.homeManagerModules.skills` to the `modules` list in your host flake
(or `skills` inside its existing `with dotfiles.homeManagerModules;` list):

```nix
modules = with dotfiles.homeManagerModules; [
  base
  skills
];
```

Home Manager links the skill files into `~/.agents/skills`, leaving other skills
in that directory available. New skills added to `config/codex/skills` are included
automatically on the next rebuild and activation. The files come from the selected
dotfiles revision in the Nix store; use the local input override above when testing
unpublished changes.

The same module links `config/codex/AGENTS.md` to `~/.codex/AGENTS.md`.
Edit the tracked copy to change these instructions. The Darwin configuration
backs up an existing unmanaged file with the `.before-home-manager` suffix
when activating; the module does not force-overwrite existing files.

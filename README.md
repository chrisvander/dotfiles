# dotfiles

Reusable nix-darwin and Home Manager components. Real hostnames, user details,
home directories, and VCS identity belong in a separate local host flake.

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

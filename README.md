# dotfiles

Reusable nix-darwin and Home Manager components. Real hostnames, user details,
home directories, and VCS identity belong in a separate local host flake.

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

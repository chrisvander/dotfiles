# Local Linux host or Docker container

Use this template on a Linux host or inside an existing Linux container with Nix
installed and `nix-command` and `flakes` enabled. It manages the user's packages
and dotfiles; it does not create an operating system or Docker image.

Set `system` to `x86_64-linux` or `aarch64-linux` to match the host or container.
Replace the user and VCS values, then select the Home Manager and language modules
you need. The user must already exist. For a root container, use username `root`
and home directory `/root`.

Build without activating:

```sh
nix build .#homeConfigurations.default.activationPackage
```

Activate as the configured user:

```sh
./result/activate
```

Open Fish with `~/.nix-profile/bin/fish`. Home Manager does not change the user's
login shell. In a container, activate during image setup if you want the changes
to survive replacing the container, and keep the Nix store available at runtime.

Keep `homeStateVersion` at its initial value when updating dependencies; it
controls compatibility defaults, not the package release.

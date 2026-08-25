# Local Darwin host

Replace the example host and user values, then select the Home Manager and
language modules this computer needs.

Build without activating:

```sh
darwin-rebuild build --flake .#default
```

Activate after reviewing the build:

```sh
darwin-rebuild switch --flake .#default
```

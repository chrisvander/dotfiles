{ pkgs, nixpkgs-unstable, lib, ... }:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;

    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "1password-cli"
      ];
  };
in {
  home.packages = with pkgs; [
    # Shell packages
    dust
    gh
    git
    eza

    # Kubernetes
    k9s
    kubectl
    kind

    # .NET
    dotnet-sdk_9

    pulumi

    llvm

    # Python
    uv
    python3

    azure-cli
    commitizen

    # Podman
    podman
    podman-compose

    # Node
    nodejs_26
    pnpm
    bun

    # Nix
    nil
    nixd
    # TailwindCSS
    tailwindcss-language-server
    # TS
    oxlint
    oxfmt
    typescript-go
    typescript-language-server
    # Astro
    astro-language-server
  ] ++ [
    unstable.jujutsu
    unstable._1password-cli
  ];
}

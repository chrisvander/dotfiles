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
    dust
    dotnet-sdk_9
    pulumi
    llvm

    # Python
    uv
    python3

    commitizen

    # Node
    nodejs_26
    azure-cli
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
    unstable._1password-cli
  ];
}

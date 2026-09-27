{ pkgs, ... }:

{
  packages = with pkgs; [
    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt
    bun
    nodejs_26
    pnpm
    typescript-go
    nixd
    nixfmt
  ];
}

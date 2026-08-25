{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt
  ];

  programs.helix.languages = lib.mkIf config.programs.helix.enable {
    language-server.rust-analyzer.command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
    language = [
      {
        name = "rust";
        language-servers = [ "rust-analyzer" ];
        auto-format = true;
      }
    ];
  };
}

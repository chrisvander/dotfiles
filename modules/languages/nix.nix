{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nixd
    nixfmt
  ];

  programs.helix.languages = lib.mkIf config.programs.helix.enable {
    language-server.nixd.command = "${pkgs.nixd}/bin/nixd";
    language = [
      {
        name = "nix";
        language-servers = [ "nixd" ];
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        auto-format = true;
      }
    ];
  };
}

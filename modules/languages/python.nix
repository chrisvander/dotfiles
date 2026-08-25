{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    python3
    ruff
    ty
    uv
  ];

  programs.helix.languages = lib.mkIf config.programs.helix.enable {
    language-server.ty.command = "${pkgs.ty}/bin/ty";
    language-server.ruff = {
      command = "${pkgs.ruff}/bin/ruff";
      args = [ "server" ];
    };
    language = [
      {
        name = "python";
        language-servers = [
          "ty"
          "ruff"
        ];
        formatter = {
          command = "${pkgs.ruff}/bin/ruff";
          args = [
            "format"
            "-"
          ];
        };
        auto-format = true;
      }
    ];
  };
}

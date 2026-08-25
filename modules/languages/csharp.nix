{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    csharpier
    dotnet-sdk_9
    netcoredbg
    omnisharp-roslyn
  ];

  programs.helix.languages = lib.mkIf config.programs.helix.enable {
    language-server.omnisharp.command = "${pkgs.omnisharp-roslyn}/bin/OmniSharp";
    language = [
      {
        name = "c-sharp";
        language-servers = [ "omnisharp" ];
        formatter = {
          command = "${pkgs.csharpier}/bin/csharpier";
          args = [ "format" ];
        };
        auto-format = true;
      }
    ];
  };
}

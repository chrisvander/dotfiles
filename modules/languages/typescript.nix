{
  config,
  lib,
  pkgs,
  ...
}:
let
  # nixpkgs still exposes TypeScript 7 under its former package name.
  typescript = pkgs.typescript-go;
  typescriptLanguage =
    name: extra:
    {
      inherit name;
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      indent = {
        tab-width = 2;
        unit = " ";
      };
      auto-format = true;
    }
    // extra;
in
{
  home.packages = [
    pkgs.biome
    pkgs.bun
    pkgs.nodejs_26
    pkgs.oxfmt
    pkgs.oxlint
    pkgs.pnpm
    typescript
    pkgs.typescript-language-server
  ];

  programs.helix.languages = lib.mkIf config.programs.helix.enable {
    language-server.typescript-language-server = {
      command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
      args = [ "--stdio" ];
    };
    language-server.biome.command = "${pkgs.biome}/bin/biome";
    language = [
      (typescriptLanguage "typescript" { })
      (typescriptLanguage "tsx" { })
      (typescriptLanguage "jsx" { grammar = "javascript"; })
      (typescriptLanguage "javascript" { })
      (typescriptLanguage "json" { })
    ];
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./typescript.nix ];

  home.packages = with pkgs; [
    astro-language-server
    prettier
    tailwindcss-language-server
  ];

  programs.helix.languages = lib.mkIf config.programs.helix.enable {
    language-server.astro-ls = {
      command = "${pkgs.astro-language-server}/bin/astro-ls";
      args = [ "--stdio" ];
    };
    language = [
      {
        name = "astro";
        scope = "source.astro";
        injection-regex = "astro";
        file-types = [ "astro" ];
        language-servers = [ "astro-ls" ];
        formatter = {
          command = "${pkgs.prettier}/bin/prettier";
          args = [
            "--plugin"
            "prettier-plugin-astro"
            "--parser"
            "astro"
          ];
        };
        auto-format = true;
      }
    ];
  };
}

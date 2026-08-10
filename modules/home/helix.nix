{ pkgs, ... }:
let
  typescriptLanguage = name: extra: {
    inherit name;
    "language-servers" = [
      {
        name = "typescript-language-server";
        "except-features" = [ "format" ];
      }
      "biome"
    ];
    indent = {
      "tab-width" = 2;
      unit = " ";
    };
    "auto-format" = true;
  } // extra;
in {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    # Available only when Helix runs.
    extraPackages = with pkgs; [
      typescript
      typescript-language-server
      tailwindcss-language-server
      biome
      astro-language-server
      prettier
    ];

    settings = {
      theme = "catppuccin_frappe";

      keys.normal = {
        "S-k" = "hover";
      };

      editor = {
        line-number = "relative";
        cursorline = true;
        mouse = false;
        bufferline = "multiple";
        color-modes = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker.hidden = false;
        lsp.display-messages = true;

        statusline = {
          left = [ "mode" "spacer" "version-control" ];
          center = [ "file-name" "file-modification-indicator" "spinner" ];
          right = [ "diagnostics" "selections" "separator" "position" "file-type" ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        indent-guides.render = true;
        soft-wrap.enable = true;
      };
    };

    languages = {
      language-server = {
        typescript-language-server = {
          command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
          args = [ "--stdio" ];
        };

        astro-ls = {
          command = "${pkgs.astro-language-server}/bin/astro-ls";
          args = [ "--stdio" ];
          config.typescript.tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";
        };
      };

      language = [
        {
          name = "astro";
          scope = "source.astro";
          injection-regex = "astro";
          file-types = [ "astro" ];
          language-servers = [ "astro-ls" ];
          formatter = {
            command = "prettier";
            args = [ "--plugin" "prettier-plugin-astro" "--parser" "astro" ];
          };
          auto-format = true;
        }
        (typescriptLanguage "typescript" { })
        (typescriptLanguage "tsx" { })
        (typescriptLanguage "jsx" { grammar = "javascript"; })
        (typescriptLanguage "javascript" { })
        (typescriptLanguage "json" { })
      ];
    };
  };
}

{ pkgs, lib, ... }:
let
  starshipConfig = with builtins; fromTOML (readFile ./starship.toml);
in
{
  xdg.configFile = {
    "fish/completions" = {
      source = ../../config/fish/completions;
      recursive = true;
    };

    "fish/conf.d" = {
      source = ../../config/fish/conf.d;
      recursive = true;
    };

    "fish/functions" = {
      source = ../../config/fish/functions;
      recursive = true;
    };
  };

  programs.fd.enable = true;
  programs.git.enable = true;
  programs.gh.enable = true;
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    git = true;
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;

    functions = {
      fish_greeting = "";
    };

    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
  };

  programs.bat = {
    enable = true;

    config = {
      theme = "ansi";
      italic-text = "always";
      map-syntax = [ "*.ignore:Git Ignore" ];
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    extraPackages = [ pkgs.jj-starship ];

    enableTransience = true;

    settings = lib.recursiveUpdate starshipConfig {
      add_newline = false;
      command_timeout = 1000;
      fill = {
        symbol = " ";
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;

    defaultOptions = [
      "--color=16"
      "--color=gutter:-1"
      "--no-mouse"
      "--margin=1"
      "--cycle"
      "--layout=reverse"
      "--height=~60%"
      "--preview-window=wrap"
      "--marker=*"
    ];
  };

  programs.ghostty.enableFishIntegration = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.man.generateCaches = false;
}

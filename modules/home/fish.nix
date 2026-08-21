{ pkgs, nixpkgs-unstable, lib, ... }:
let
  starshipConfig = with builtins; fromTOML (readFile ./starship.toml);
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;

    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "1password-cli"
      ];
  };
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

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    MANPAGER = "bat -l man";
  };

  home.shellAliases = {
    # alias for bat
    cat = "bat";
    # alias for bottom
    top = "btm";
    # git aliases
    gs = "git status";
    gc = "git commit";
    gch = "git checkout";
    gp = "git push";
    gpl = "git pull";
  };

  programs.bottom.enable = true;
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fd.enable = true;
  programs.git.enable = true;
  programs.gh = {
    enable = true;
    settings.aliases.co = "pr checkout";
  };
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    git = true;
    icons = "always";
    colors = "always";
  };

  programs.delta = {
    enable = true;
    enableJujutsuIntegration = true;
    enableGitIntegration = true;
  };

  programs.fish = {
    enable = true;

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

  programs.jujutsu = {
    enable = true;
    package = unstable.jujutsu;
    settings = {
      user = {
        email = "chris.vanderloo@icloud.com";
        name = "Chris van der Loo";
      };
      ui = {
        default-command = "log";
      };
    };
  };

  programs.ghostty.enableFishIntegration = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.man.generateCaches = false;
}

{ pkgs, lib, ... }:
let
  base = with builtins; fromTOML (readFile ./starship.toml);
in {
  programs.starship = {
    enable = true;
    extraPackages = [ pkgs.jj-starship ];

    enableFishIntegration = true;
    enableTransience = true;

    settings = lib.recursiveUpdate base {
      add_newline = false;
      command_timeout = 1000;
      fill = {
        symbol = " ";
      };
    };
  };
}

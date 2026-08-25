{
  pkgs,
  nixpkgs-unstable,
  lib,
  ...
}:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "1password-cli" ];
  };
in
{
  home.packages = [
    pkgs.commitizen
    pkgs.dust
    unstable._1password-cli
  ];
}

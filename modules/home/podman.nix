{ pkgs, ... }: {

  home.shellAliases = {
    docker = "podman";
    d = "podman";
    dc = "podman-compose";
  };

  home.packages = with pkgs; [
    podman
    podman-compose
  ];
}

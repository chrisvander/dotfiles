{ pkgs, ... }: {
  home.shellAliases = {
    k = "kubectl";
    kc = "kubectl config get-contexts";
    ks = "kubectl config set-context";
  };
  programs.k9s.enable = true;
  home.packages = with pkgs; [
    kubectl
  ];
}

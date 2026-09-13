{ pkgs, ... }: {
  home.shellAliases = {
    k = "kubectl";
    kc = "kubectl config get-contexts";
    ks = "kubectl config set-context";
  };
  programs.k9s = {
    enable = true;
    settings.k9s.ui.skin = "terminal";
    skins.terminal.k9s = {
      body = {
        fgColor = "default";
        bgColor = "default";
      };
      prompt.bgColor = "default";
      info.sectionColor = "default";
      dialog = {
        bgColor = "default";
        labelFgColor = "default";
        fieldFgColor = "default";
      };
      frame = {
        crumbs.bgColor = "default";
        title = {
          bgColor = "default";
          counterColor = "default";
        };
        menu.fgColor = "default";
      };
      views = {
        charts.bgColor = "default";
        table = {
          bgColor = "default";
          header = {
            fgColor = "default";
            bgColor = "default";
          };
        };
        xray.bgColor = "default";
        logs = {
          bgColor = "default";
          indicator = {
            bgColor = "default";
            toggleOnColor = "default";
            toggleOffColor = "default";
          };
        };
        yaml = {
          colonColor = "default";
          valueColor = "default";
        };
      };
    };
  };
  home.packages = with pkgs; [
    kind
    kubectl
  ];
}

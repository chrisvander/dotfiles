{
  programs.ghostty = {
    enable = true;
    package = null;

    settings = {
      theme = "dark:Catppuccin Mocha,light:Catppuccin Latte";

      font-family = "MonaspiceNe Nerd Font Mono";
      font-size = 14;
      adjust-cell-height = 6;
      adjust-font-baseline = -2;

      background-opacity = 0.9;
      background-blur-radius = 30;

      window-padding-x = 8;
      window-padding-balance = true;
      window-padding-color = "extend";
      window-step-resize = true;
    };
  };
}

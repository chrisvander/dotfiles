{ ... }: {
  programs.fish = {
    enable = true;
    generateCompletions = true;
  };

  programs.man.generateCaches = false;
}

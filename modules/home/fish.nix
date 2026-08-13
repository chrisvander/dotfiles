{ ... }: {
  programs.fish = {
    enable = true;
    generateCompletions = true;

    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
  };

  programs.man.generateCaches = false;
}

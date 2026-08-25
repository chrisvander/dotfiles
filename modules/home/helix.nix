{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "catppuccin_frappe";

      keys.normal = {
        "S-k" = "hover";
      };

      editor = {
        line-number = "relative";
        cursorline = true;
        mouse = false;
        bufferline = "multiple";
        color-modes = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker.hidden = false;
        lsp.display-messages = true;

        statusline = {
          left = [
            "mode"
            "spacer"
            "version-control"
          ];
          center = [
            "file-name"
            "file-modification-indicator"
            "spinner"
          ];
          right = [
            "diagnostics"
            "selections"
            "separator"
            "position"
            "file-type"
          ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        indent-guides.render = true;
        soft-wrap.enable = true;
      };
    };

  };
}

{ config, pkgs, ... }:
let
  theme =
    name: colors:
    let
      pill =
        bg: fg: text:
        "#[fg=${bg},bg=default]#[fg=${fg},bg=${bg}] ${text} #[fg=${bg},bg=default]#[default]";
    in
    pkgs.writeText "tmux-catppuccin-${name}.conf" ''
      set -g @catppuccin_flavor "${name}"
      set -g status-style "bg=default,fg=${colors.text}"
      set -g pane-border-style "fg=${colors.surface}"
      set -g pane-active-border-style "fg=${colors.mauve}"
      set -g message-style "bg=${colors.surface},fg=${colors.text}"
      set -g message-command-style "bg=${colors.surface},fg=${colors.text}"
      set -g mode-style "bg=${colors.blue},fg=${colors.base}"
      set -g window-status-style "bg=default,fg=${colors.muted}"
      set -g window-status-current-style "bg=default,fg=${colors.text}"
      set -g window-status-activity-style "fg=${colors.mauve}"
      set -g window-status-separator " "
      set -g window-status-format "${pill colors.surface colors.muted " #W"}"
      set -g window-status-current-format "${
        pill colors.mauve colors.base " #W#{?window_zoomed_flag, 󰊓,}"
      }"
      set -g status-left "${pill colors.green colors.base "#{?client_prefix,,} #S"}  "
      set -g status-right "${
        pill colors.surface colors.blue " #{b:pane_current_path}"
      }  #[fg=${colors.muted}]󰥔 %H:%M "
    '';

  mocha = theme "mocha" {
    base = "#1e1e2e";
    text = "#cdd6f4";
    surface = "#313244";
    muted = "#a6adc8";
    mauve = "#cba6f7";
    blue = "#89b4fa";
    green = "#a6e3a1";
  };
  latte = theme "latte" {
    base = "#eff1f5";
    text = "#4c4f69";
    surface = "#ccd0da";
    muted = "#6c6f85";
    mauve = "#8839ef";
    blue = "#1e66f5";
    green = "#40a02b";
  };
in
{
  programs.starship.settings.custom.tmux_sessions = {
    when = ''test -z "$TMUX"'';
    command = ''
      ${pkgs.tmux}/bin/tmux display-message -p '#{server_sessions}' 2>/dev/null
    '';
    shell = [ pkgs.runtimeShell ];
    format = "([󰖲 $output]($style) )";
    style = "bold purple";
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "tmux-256color";
    shell = "${pkgs.fish}/bin/fish";
    keyMode = "vi";
    focusEvents = true;
    historyLimit = 50000;
    plugins = [ pkgs.tmuxPlugins.extrakto ];

    extraConfig = ''
      set -as terminal-features ",xterm-ghostty:RGB:clipboard"
      set -s set-clipboard external

      bind % split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"
      bind r source-file "${config.xdg.configHome}/tmux/tmux.conf" \; display-message "tmux configuration reloaded"

      set -g status-left-length 40
      set -g status-right-length 60

      # Ghostty reports its appearance on attachment and whenever it changes.
      set-hook -g client-dark-theme "source-file ${mocha}"
      set-hook -g client-light-theme "source-file ${latte}"

      # Also pick up the current appearance when loading into an existing session.
      if-shell -F '#{==:#{client_theme},light}' {
        source-file ${latte}
      } {
        source-file ${mocha}
      }
    '';
  };
}

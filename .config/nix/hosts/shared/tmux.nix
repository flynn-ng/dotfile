{ pkgs, tmux-powerkit, ... }:
let
  cyberdreamTheme = pkgs.writeText "cyberdream-dark.sh" ''
    #!/usr/bin/env bash
    # Cyberdream Dark Theme for tmux-powerkit
    # Source: https://github.com/scottmckendry/cyberdream.nvim
    declare -gA THEME_COLORS=(
        [background]="#16181a"

        [statusbar-bg]="#16181a"
        [statusbar-fg]="#ffffff"

        [session-bg]="#5eff6c"
        [session-fg]="#16181a"
        [session-prefix-bg]="#ffbd5e"
        [session-copy-bg]="#ff5ef1"
        [session-search-bg]="#f1ff5e"
        [session-command-bg]="#bd5eff"

        [window-active-base]="#5ea1ff"
        [window-active-style]="bold"

        [window-inactive-base]="#7b8496"
        [window-inactive-style]="none"

        [window-activity-style]="italics"
        [window-bell-style]="bold"
        [window-zoomed-bg]="#5ef1ff"

        [pane-border-active]="#5eff6c"
        [pane-border-inactive]="#7b8496"

        [ok-base]="#3c4048"
        [good-base]="#5eff6c"
        [info-base]="#ff5ea0"
        [warning-base]="#ffbd5e"
        [error-base]="#ff6e5e"
        [disabled-base]="#7b8496"

        [message-bg]="#16181a"
        [message-fg]="#ffffff"

        [popup-bg]="#16181a"
        [popup-fg]="#ffffff"
        [popup-border]="#5eff6c"
        [menu-bg]="#16181a"
        [menu-fg]="#ffffff"
        [menu-selected-bg]="#5eff6c"
        [menu-selected-fg]="#16181a"
        [menu-border]="#7b8496"
    )
  '';

  plugins = with pkgs.tmuxPlugins; [
    sensible
    yank
    resurrect
    continuum
    vim-tmux-navigator
    tmux-powerkit.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  pluginConfig = pkgs.lib.concatMapStringsSep "\n" (p: "run-shell ${p.rtp}") plugins;
in
{
  programs.tmux = {
    enable = true;
    enableMouse = true;
    enableVim = true;

    extraConfig = ''
      # Terminal settings
      set -g default-terminal "screen-256color"
      set -ag terminal-overrides ",$TERM:Tc"

      # Base index
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Status bar
      set -g status-position top
      set -g status-bg default
      set -g status-style bg=default
      set-option -g status-style bg=default

      # Vi-mode keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Prefix
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      # Window navigation
      bind -n M-H previous-window
      bind -n M-L next-window

      # Open panes in current directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # Restore session manager (overridden by enableVim)
      bind s choose-tree -Zs

      # Powerkit: cyberdream theme
      set -g @powerkit_theme "custom"
      set -g @powerkit_custom_theme_path "${cyberdreamTheme}"
      set -g @powerkit_transparent "true"
      set -g @powerkit_plugins "git,bitwarden,group(cpu,memory),battery,datetime"
      set -g @powerkit_plugin_group_colors "info-base-darker,window-active-base-darker,ok-base-darker,warning-base-darker,error-base-darker,disabled-base"
      set -g @powerkit_plugin_group_coloring "true"
      set -g @powerkit_separator_style "slant"
      set -g @powerkit_edge_separator_style "slant"
      set -g @powerkit_elements_spacing "plugins"
      set -g @powerkit_status_order "session,plugins"
      set -g @powerkit_plugin_datetime_format " %d/%m %I:%M %p"
      set -g @yank_action 'copy-pipe'

      # Load plugins
      ${pluginConfig}
    '';
  };
}

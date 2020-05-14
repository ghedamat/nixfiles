{
  home.file.".tmux.conf".text = ''
    #set -g default-terminal "screen-256color"
    set -g default-terminal "xterm"
    set -ga terminal-overrides ",rxvt*:XT"

    # Turn on window titles
    set -g set-titles on
    # Set window title string
    #  #H  Hostname of local host
    #  #I  Current window index
    #  #P  Current pane index
    #  #S  Session name
    #  #T  Current window title
    #  #W  Current window name
    #  #   A literal ‘#’
    set -g set-titles-string '#S:#I.#P #W'

    # Automatically set window title
    setw -g automatic-rename

    setw -g mode-keys vi
    set -sg escape-time 1
    unbind C-a
    set -g prefix C-'\'

    set -g base-index 1
    setw -g pane-base-index 1
    #bind r source-file ~/.tmux.conf; display "reloaded!"
    bind-key C-b send-prefix

    bind -n M-\\ split-window -h
    bind -n M-- split-window -v

    bind -n M-h select-pane -L
    bind -n M-j select-pane -D
    bind -n M-k select-pane -U
    bind -n M-l select-pane -R

    bind -n M-n next-window
    bind -n M-b previous-window

    bind -n M-N next-window
    bind -n M-B previous-window

    bind -r C-h select-window -t :-
    bind -r C-l select-window -t :+

    bind -nr M-H resize-pane -L 5
    bind -nr M-J resize-pane -D 5
    bind -nr M-K resize-pane -U 5
    bind -nr M-L resize-pane -R 5
    bind -nr M-m resize-pane -Z
    bind -nr C-M-h resize-pane -L 5
    bind -nr C-M-j resize-pane -D 5
    bind -nr C-M-k resize-pane -U 5
    bind -nr C-M-l resize-pane -R 5
    bind -nr M-m resize-pane -Z
    #bind -nr C-M-N switch-client -n
    #bind -nr C-M-B switch-client -p

    #setw -g mode-mouse on
    #set -g mouse-select-pane on
    #set -g mouse-resize-pane on
    #set -g mouse-select-window on

    setw -g window-status-style fg=cyan,bg=default,dim
    setw -g window-status-current-style fg=white,bg=red,bright

    set -g pane-active-border-style fg=white,bg=yellow
    set -g pane-border-style fg=green,bg=black

    #set -g message-fg white
    #set -g message-bg black
    #set -g message-attr bright

    setw -g monitor-activity on
    setw -g main-pane-height 40
    set -g visual-activity on


    #### COLOUR (Solarized 256)

    # default statusbar colors
    set-option -g status-style bg=colour235 #base02,fg=colour136 #yellow,default


    # default window title colors
    set-window-option -g window-status-style fg=colour244 #base0,bg=default,dim

    # active window title colors
    set-window-option -g window-status-current-style fg=colour166 #orange,bg=default,bright

    # pane border
    set-option -g pane-border-style bg=colour235 #base02,fg=colour240 #base01

    # message text
    set-option -g message-style bg=colour235 #base02,fg=colour166 #orange

    # pane number display
    set-option -g display-panes-active-colour colour33 #blue
    set-option -g display-panes-colour colour166 #orange

    # clock
    set-window-option -g clock-mode-colour colour64 #green


    # COPY MODE KEYS
    unbind [
    bind -n M-v copy-mode
    unbind p
    bind -n M-p paste-buffer
    bind -T copy-mode-vi 'v' send-keys -X begin-selection
    bind -T copy-mode-vi 'y' send-keys -X copy-selection

    bind C-c run "tmux save-buffer - | xclip -i -sel clipboard"
    bind C-v run "tmux set-buffer \"$(xclip -o -sel clipboard)\"; tmux paste-buffer"

    bind -n M-x new-window
    bind -n M-: command-prompt

    bind -n M-/ capture-pane -S -32767 \; new-window ' \
      { tmux save-buffer -; tmux delete-buffer; } | {  \
        tmux send-keys G \?;                           \
        vim -R -c "set is hls ic" - || less;           \
      };                                               \
    '

    set -g status-left-length 52
    set -g status-right-length 451
    set -g status-style fg=white,bg=colour234
    set -g window-status-activity-style bold
    set -g pane-border-style bg=colour245,fg=colour39
    set -g message-style fg=colour16,bg=colour221,bold
    #set -g status-left '#[fg=colour235,bg=colour252,bold] ❐ #S #[fg=colour252,bg=colour238,nobold]⮀#[fg=colour245,bg=colour238,bold] #(whoami) #[fg=colour238,bg=colour234,nobold]⮀'
    set -g status-right "#{=21:pane_title} %H:%M %d-%b-%y #[fg=red,dim,bg=default]#(hostname)"
    set -g window-status-format "#[fg=white,bg=colour234] #I #W "
    #set -g window-status-current-format "#[fg=colour234,bg=colour39]⮀#[fg=colour25,bg=colour39,noreverse,bold] #I ⮁ #W #[fg=colour39,bg=colour234,nobold]⮀"
    set-option -g status-position top

    set -g mouse on
    #bind-key -t vi-copy WheelUpPane scroll-up
    #bind-key -t vi-copy WheelDownPane scroll-down

    # to enable mouse scroll, see https://github.com/tmux/tmux/issues/145#issuecomment-150736967
    bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"

    #set-option -g default-command "reattach-to-user-namespace -l zsh"
    # Use vim keybindings in copy mode
    setw -g mode-keys vi
  '';
}

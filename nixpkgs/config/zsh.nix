{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "rbenv" ];
    };
    shellAliases = {
      vi = "vim";
      ssh = "color-ssh";
    };
    profileExtra = "";
    initExtra = ''
      stty stop undef
      stty start undef
      setopt noflowcontrol

      eval `keychain --eval --agents ssh id_rsa 2018_id_rsa`
      export TERM=xterm-256color
      [ -n "$TMUX" ] && export TERM=screen-256color
      source "$(fzf-share)/key-bindings.zsh"

      case $TERM in
      screen*)
      precmd(){
      # Restore tmux-title to 'zsh'
      printf "\033kzsh\033\\"
      # Restore urxvt-title to 'zsh'
      print -Pn "\e]2;zsh:%~\a"
      }
      preexec(){
      # set tmux-title to running program
      printf "\033k$(echo "$1" | cut -d" " -f1)\033\\"
      # set urxvt-title to running program
      print -Pn "\e]2;zsh:$(echo "$1" | cut -d" " -f1)\a"
                }
      ;;
      esac

      color-ssh() {
      trap "colorterm.sh" INT EXIT
      if [[ "$*" =~ "prod" ]]; then
      colorterm.sh prod
      elif [[ "$*" =~ "dev" ]]; then
      colorterm.sh dev
      elif [[ "$*" =~ "ghedamat-roof" ]]; then
      colorterm.sh ghedamat-roof
      else
      colorterm.sh other
      fi
      ssh $*
      }
      compdef _ssh color-ssh=ssh

      PATH=$PATH:$HOME/npm-prefix/bin
      PATH=$PATH:$HOME/bin

      export FZF_DEFAULT_COMMAND='fd --type f --exclude .git'
    '';
  };
}

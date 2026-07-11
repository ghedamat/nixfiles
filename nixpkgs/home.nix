{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  home.stateVersion = "25.05";
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.npm-global/bin"
  ];
  programs.home-manager.enable = true;
  imports = [
    ./config/shell.nix
    ./config/programs.nix
    ./config/git.nix
    ./config/spacevim.nix
  ];


  programs.bash = {
    enable = true;
    enableAutojump = true;
    profileExtra = ''
      . /Users/ghedamat/.nix-profile/etc/profile.d/nix.sh
    '';
  };

  home.packages = with pkgs; [
    fd
    fzf
    keychain
    solargraph
    rustup
    nodejs
    silver-searcher
    tig
    git-up
    ripgrep
    devenv
  ];


  ghedamat = {

    shell = {
      starship = {
        enable = true;
        configFile = "starship-x280.toml";
      };
      zsh = {
        enable = true;
      };
    };

    programs = {
      tmux.enable = true;
    };
  };

#  home.file.".mackup.cfg".source = ./config/programs/mackup/mackup.cfg;
}

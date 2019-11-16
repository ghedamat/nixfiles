{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.bash = {
    enable = true;
    enableAutojump = true;
    profileExtra = ''
    . /Users/ghedamat/.nix-profile/etc/profile.d/nix.sh
    '';
  };

  home.packages = with pkgs; [
    vscode
    homesick
    (import ./../common/neovim.nix)
    fzf
    solargraph
    rustup
  ];

  imports = [
    ./config/tmux.conf.nix
    ./config/git.nix
    ./config/zsh.nix
  ];

  programs.zsh = {
    oh-my-zsh = {
      theme = "robbyrussell";
    };
    profileExtra = ''
      . /Users/ghedamat/.nix-profile/etc/profile.d/nix.sh
      . ${pkgs.autojump}/share/autojump/autojump.zsh
      export NIX_PATH=/Users/ghedamat/.nix-defexpr/channels/
      export PATH=$PATH:$HOME/npm-prefix/bin
    '';
  };

}

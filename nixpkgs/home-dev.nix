{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    vscode
    homesick
    fzf
  ];

  imports = [
    ./config/tmux.conf.nix
    ./config/git.nix
    ./config/zsh.nix
  ];

  programs.zsh = {
    oh-my-zsh = {
      theme = "minimal";
    };
    profileExtra = ''
      export PATH=$PATH:$HOME/.npm-prefix/bin
    '';
  };
}

{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    vscode
    homesick
    fzf
    meld
    starship
  ];

  imports = [
    ./config/tmux.conf.nix
    ./config/git.nix
    ./config/zsh.nix
    ./config/starship-dev.toml.nix
  ];

  programs.zsh = {
    oh-my-zsh = {
      theme = "minimal";
    };
    profileExtra = ''
      export PATH=$PATH:$HOME/.npm-prefix/bin
    '';
    initExtraBeforeCompInit = ''
      eval "$(starship init zsh)"
    '';
  };
}

{ config, pkgs, ... }:

let unstable = import <unstable> { };
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    vscode
    homesick
    fzf
    meld
    unstable.starship
    pass
  ];

  imports = [
    ./config/git.nix
    ./config/zsh.nix
    ./SpaceVim.d/space-vim.nix
  ];

  home.file.".config/starship.toml".source = ./config/starship-dev.toml;
  home.file.".tmux.conf".source = ./config/tmux.conf;

  programs.zsh = {
    oh-my-zsh = { theme = "minimal"; };
    profileExtra = ''
      export PATH=$PATH:$HOME/.npm-prefix/bin
    '';
    initExtraBeforeCompInit = ''
      eval "$(starship init zsh)"
    '';
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "2018_id_rsa" ];
  };
}

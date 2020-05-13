{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
in
  {
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

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      sshKeys = [
        "2018_id_rsa"
      ];
    };
  }

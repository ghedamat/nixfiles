{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  home.stateVersion = "22.11";
  home.username = "ghedamat";
  home.homeDirectory = "/Users/ghedamat";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
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
    (import ./../common/packages/neovim.nix)
    fd
    fzf
    keychain
    solargraph
    rustup
    nodejs
    silver-searcher
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

    spacevim.enable = true;
  };

}

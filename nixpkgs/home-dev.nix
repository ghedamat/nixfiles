{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./config/shell.nix
    ./config/programs.nix
    ./config/git.nix
    ./config/packages.nix
    ./config/spacevim.nix
  ];

  ghedamat = {
    shell = {
      starship = {
        enable = true;
        configFile = "starship-dev.toml";
      };
      zsh.enable = true;
    };
    programs = {
      tmux.enable = true;
      vsliveshare.enable = true;
    };
    spacevim.enable = true;
  };
  programs.bat.enable = true;
  programs.go.enable = true;
}

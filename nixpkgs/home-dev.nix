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

  home.packages = with pkgs;
    [ (import ../common/packages/remarkable-to-png.nix) ];

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
      postgresql.enable = true;
    };
    spacevim.enable = true;
  };
  programs.bat.enable = true;
  programs.go.enable = true;
}

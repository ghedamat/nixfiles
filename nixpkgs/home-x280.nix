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
    ./config/xfiles.nix
  ];

  home.packages = with pkgs; [
    obsidian
  ];

  home.file."/bin/colorterm.sh".source = ./bin/colorterm.sh;
  ghedamat = {

    shell = {
      starship = {
        enable = true;
        configFile = "starship-x280.toml";
      };
      zsh = {
        enable = true;
        direnv = true;
      };
    };

    programs = {
      zoom.enable = true;
      tmux.enable = true;
      vsliveshare.enable = true;
      alacritty = {
        enable = true;
        configFile = "x280.yml";
      };
      i3 = {
        enable = true;
        configFile = "config-x280";
        statusFile = "status-x280.toml";
      };
    };

    spacevim.enable = true;

    xfiles = {
      enable = true;
      xinitrcFile = "xinitrc-x280";
      xprofileFile = "xprofile-x280";
    };
  };

  programs.bat.enable = true;
  programs.go.enable = true;

  gtk = {
    enable = true;
    theme = {
      package = pkgs.theme-vertex;
      name = "Vertex-Dark";
    };
    iconTheme = {
      package = pkgs.tango-icon-theme;
      name = "Tango";
    };
  };

}

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
    #zoom-us
    remmina
    rofimoji
  ];

  home.file."/bin/focus.sh".source = ./bin/focus.sh;
  home.file."/bin/colorterm.sh".source = ./bin/colorterm.sh;
  ghedamat = {

    shell = { zsh = { enable = true; }; };

    programs = {
      tmux.enable = true;
      timeular.enable = true;
      alacritty = {
        enable = true;
        configFile = "hydralisk.yml";
      };
      i3 = {
        enable = true;
        configFile = "config-desktop";
        statusFile = "status-desktop.toml";
      };
    };

    spacevim.enable = true;

    xfiles = {
      enable = true;
      xinitrcFile = "xinitrc-hydralisk";
      xprofileFile = "xprofile-hydralisk";
    };
  };

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

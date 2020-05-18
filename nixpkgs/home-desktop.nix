{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [ vscode ];

  imports = [
    ./config/git.nix
    ./config/zsh.nix
  ];

  home.file.".config/tmux.conf".source = ./config/tmux.conf;
  home.file."/bin/focus.sh".source = ./bin/focus.sh;
  home.file.".config/i3/config".source = ./config/i3/config-desktop;
  home.file.".config/i3/status.toml".source = ./config/i3/status-desktop.toml;

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

{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.file.".config/i3/config".source = config/i3/config;
  home.file.".config/i3/status.toml".source = config/i3/status.toml;
  home.file.".tmux.conf".source = config/tmux.conf;
  home.file.".xinitrc".source = config/X/xinitrc;

}

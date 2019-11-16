{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    vscode
    homesick
    fzf
    (import ./../common/neovim.nix)
  ];

  imports = [
    ./config/i3/config.nix
    ./config/i3/status.toml.nix
    ./config/tmux.conf.nix
    ./config/git.nix
    ./config/zsh.nix
  ];

  programs.zsh.oh-my-zsh.theme = "gentoo";

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

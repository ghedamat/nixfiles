{ config, pkgs, ... }:

let unstable = import <unstable> { };
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./config/git.nix
    ./config/zsh.nix
    ./config/programs.nix
    ./config/services.nix
    ./config/packages.nix
    ./SpaceVim.d/space-vim.nix
    ./xfiles/xfiles-x280.nix
  ];

  home.file.".tmux.conf".source = ./config/tmux.conf;
  home.file.".config/starship.toml".source = ./config/starship-x280.toml;
  home.file.".config/alacritty/alacritty.yml".source = ./config/alacritty.yml;
  home.file.".config/i3/config".source = ./config/i3/config-x280;
  home.file.".config/i3/status.toml".source = ./config/i3/status-x280.toml;

  programs.zsh = {
    oh-my-zsh = { theme = "minimal"; };
    initExtraBeforeCompInit = ''
      eval "$(starship init zsh)"
    '';
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

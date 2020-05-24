{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;


  imports = [
    ./config/git.nix
    ./config/zsh.nix
    ./config/programs.nix
    ./config/packages.nix
  ];

  home.file.".config/tmux.conf".source = ./config/tmux.conf;
  home.file."/bin/focus.sh".source = ./bin/focus.sh;
  home.file.".config/i3/config".source = ./config/i3/config-desktop;
  home.file.".config/i3/status.toml".source = ./config/i3/status-desktop.toml;

  programs.zsh = {
    oh-my-zsh = { theme = "minimal"; };
    profileExtra = ''
      export PATH=$PATH:$HOME/.npm-prefix/bin
    '';
    initExtraBeforeCompInit = ''
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

{ config, pkgs, lib, ... }: {
  imports = [
#    ./config/tmux.nix
#    ./config/ack.nix
#    ./config/git.nix
  ];
  home.username = "ghedamat";
  home.homeDirectory = "/Users/ghedamat/";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    git
    ack
    ripgrep
    nodejs
    tmux
    devenv
    gh
  ];

  # global node packages
  home.activation.npmPackages = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Installing/updating global npm packages..."
    export PATH="${pkgs.nodejs}/bin:$PATH"

    # dedicated global npm prefix to avoid conflicts
    mkdir -p $HOME/.npm-global
    ${pkgs.nodejs}/bin/npm config set prefix $HOME/.npm-global

    # Install/update Claude Code
    ${pkgs.nodejs}/bin/npm install -g @anthropic-ai/claude-code@latest
  '';

  programs.zsh = {
    enable = true;
    initExtra = ''
      export PATH="$HOME/.npm-global/bin:$PATH"
    '';
    shellAliases = {
      hms = "home-manager switch --flake ~/.config/home-manager#vagrant@accomplisher";
    };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      export PATH="$HOME/.npm-global/bin:$PATH"
    '';
    shellAliases = {
      hms = "home-manager switch --flake ~/.config/home-manager#vagrant@accomplisher";
    };
  };

  programs.home-manager.enable = true;
}

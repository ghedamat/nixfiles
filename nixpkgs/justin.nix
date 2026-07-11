{ config, pkgs, lib, ... }: {
  imports = [
#    ./config/tmux.nix
#    ./config/ack.nix
#    ./config/git.nix
  ];
  home.username = "ghedamat";
  # Keep this normalized: a trailing slash makes Home Manager's Zsh module
  # generate ~/.zshenv as a redirect to itself.
  home.homeDirectory = "/Users/ghedamat";
  home.stateVersion = "24.05";

  home.sessionPath = [ "$HOME/.local/bin" ];

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

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    keys = [ "id_rsa" "2018_id_rsa" "id_ed25519" ];
  };

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

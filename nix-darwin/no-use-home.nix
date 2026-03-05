{ config, pkgs, lib, ... }:
let
  strtr = import ./strtr.nix { inherit pkgs; };
in
{
  home.homeDirectory = "/Users/ghedamat";
  home.username = "ghedamat";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    ack
    ripgrep
    nodejs
    git
    gh
    _1password-cli
    devenv
    strtr
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

    # Install/update Cloudflare Wrangler
    ${pkgs.nodejs}/bin/npm install -g wrangler@latest
  '';

  programs.zsh = {
    enable = true;
    initExtra = ''
      export PATH="$HOME/.npm-global/bin:$PATH"

      ssh-add --apple-load-keychain -q
      alias sshfwd='ssh -o IdentityAgent=$SSH_AUTH_SOCK'
      alias cursor='/Applications/Cursor.app/Contents/Resources/app/bin/cursor'
      alias hms='sudo nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake flake.nix#thaair'

    '';
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      export PATH="$HOME/.npm-global/bin:$PATH"

      ssh-add --apple-load-keychain -q
      alias sshfwd='ssh -o IdentityAgent=$SSH_AUTH_SOCK'
      alias cursor='/Applications/Cursor.app/Contents/Resources/app/bin/cursor'
      alias hms='sudo nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake flake.nix#thaair'
    '';
  };

  programs.home-manager.enable = true;

  # Add other home-manager config here
  # programs.git.enable = true;
  # etc...
}

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    curl

    git
    tig

    ruby
    yarn
    nodejs-10_x

    (import ./vim.nix)
    (import ./neovim.nix)
    emacs

    zsh
    keychain
    homesick
    fzf
    autojump
    tmux
    source-code-pro
    silver-searcher

    htop
  ];
}

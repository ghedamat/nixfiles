{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    curl

    git
    tig

    ruby
    yarn
    nodejs-11_x

    (import ./vim.nix)
    neovim
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

{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    curl

    git
    tig

    ruby
    yarn
    nodejs-12_x
    perl

    (import ./packages/vim.nix)
    (import ./packages/neovim.nix)
    emacs

    zsh
    keychain
    homesick
    fzf
    autojump
    tmux
    source-code-pro
    ag

    htop
    nixfmt
    (pkgs.callPackage ./packages/comma.nix { })
  ];
}

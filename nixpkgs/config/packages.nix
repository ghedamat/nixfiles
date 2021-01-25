{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    homesick
    fzf
    meld
    pass
    ngrok
    (import ./../../common/packages/neovim.nix)
    vscode
    nnn
    anki
    ripgrep
    tig
    niv
    #(import ./../../common/packages/standardnotes.nix)
  ];
}

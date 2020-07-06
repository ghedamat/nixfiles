{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    homesick
    fzf
    meld
    starship
    pass
    ngrok
    (import ./../../common/packages/neovim.nix)
    vscode
    nnn
  ];
}

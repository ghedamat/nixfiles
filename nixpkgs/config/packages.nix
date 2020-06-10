{ config, pkgs, ... }:
let unstable = import <unstable> { };
in {
  home.packages = with pkgs; [
    homesick
    fzf
    meld
    unstable.starship
    pass
    (import ./../../common/packages/neovim.nix)
    unstable.vscode
    nnn
  ];
}

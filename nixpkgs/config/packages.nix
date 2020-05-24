{ config, pkgs, ... }:
let unstable = import <unstable> { };
in {
  home.packages = with pkgs; [
    vscode
    homesick
    fzf
    meld
    unstable.starship
    pass
    (import ./../../common/packages/neovim.nix)
  ];
}

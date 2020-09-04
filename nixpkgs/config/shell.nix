{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.shell;
in {
  imports = [
    ./shell/starship.nix
    ./shell/zsh.nix
  ];
}

{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.programs.tmux;
in {
  options = { ghedamat.programs.tmux.enable = mkEnableOption "enable tmux"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ tmux ];
    home.file.".tmux.conf".source = ./tmux.conf;
  };
}


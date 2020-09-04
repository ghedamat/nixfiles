{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.programs.zoom;
in {
  options = { ghedamat.programs.zoom.enable = mkEnableOption "enable zoom"; };
  config = mkIf cfg.enable { home.packages = with pkgs; [ zoom-us ]; };
}


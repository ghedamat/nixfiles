{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.programs.timeular;
in {
  options = { ghedamat.programs.timeular.enable = mkEnableOption "enable timeular"; };
  config = mkIf cfg.enable { home.packages = with pkgs; [ timeular ]; };
}


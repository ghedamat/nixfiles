{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.programs.rescuetime;
in {
  options = {
    ghedamat.programs.timeular.enable = mkEnableOption "enable rescuetime";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [ rescuetime ];
  };
}


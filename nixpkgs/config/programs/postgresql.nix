{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.programs.postgresql;
in {
  options = { ghedamat.programs.postgresql.enable = mkEnableOption "enable psqlrc"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ postgresql ];
    home.file.".psqlrc".source = ./postgresql/psqlrc;
  };
}


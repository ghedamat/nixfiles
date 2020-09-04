{ config, pkgs, lib, ... }:
with lib;
let cfg = config.ghedamat.programs.i3;
in {
  options = {
    ghedamat.programs.i3.enable = mkEnableOption "enable i3";
    ghedamat.programs.i3.configFile = mkOption {
      type = types.str;
      default = "config";
    };
    ghedamat.programs.i3.statusFile = mkOption {
      type = types.str;
      default = "status";
    };
  };
  config = mkIf cfg.enable {
    home.file.".config/i3/config".source = ./. + ("/i3/" + cfg.configFile);
    home.file.".config/i3/status.toml".source = ./. + ("/i3/" + cfg.statusFile);
  };
}



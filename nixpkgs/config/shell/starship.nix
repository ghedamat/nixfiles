{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.shell.starship;
in {
  options = {
    ghedamat.shell.starship.enable = mkEnableOption "enable starship";
    ghedamat.shell.starship.configFile = mkOption {
      type = types.str;
      default = "starship.toml";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ starship ];
    home.file.".config/starship.toml".source = ./. + ("/" + cfg.configFile);
  };
}


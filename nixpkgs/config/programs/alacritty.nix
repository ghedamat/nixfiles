{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.programs.alacritty;
in {
  options = {
    ghedamat.programs.alacritty.enable = mkEnableOption "enable alacritty";
    ghedamat.programs.alacritty.configFile = mkOption {
      type = types.str;
      default = "alacritty.yml";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ alacritty ];
    home.file.".config/alacritty/alacritty.yml".source = ./.
      + ("/alacritty/" + cfg.configFile);
  };
}


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

    services.dunst = {
      enable = true;
      settings = {
        global = {
          geometry = "600x5-30+20";
          separator_height = 2;
          padding = 8;
          horizontal_padding = 8;
          font = "DejaVu Sans Mono 10";
          format = ''
            <b>%s</b>
            %b'';
          icon_position = "left";
          max_icon_size = 48;
          indicate_hidden = "yes";
          shrink = "no";
          frame_color = "#aaaaaa";
          markup = "full";
          word_wrap = "yes";
          ignore_newline = "no";
          stack_duplicates = true;
          hide_duplicate_count = false;
          show_indicators = "yes";
          monitor = 2;

          dmenu = "rofi -dmenu -p Dunst";
          browser = "xdg-open";
        };
        shortcuts = {
          close = "ctrl+space";
          history = "ctrl+grave";
          context = "ctrl+shift+period";
        };
      };
    };
  };
}


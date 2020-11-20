{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.xfiles;
in {
  options = {
    ghedamat.xfiles.enable = mkEnableOption "enable xfiles";
    ghedamat.xfiles.xinitrcFile = mkOption {
      type = types.str;
      default = "xinitrc";
    };
    ghedamat.xfiles.xprofileFile = mkOption {
      type = types.str;
      default = "xprofile";
    };
    ghedamat.xfiles.xresourcesFile = mkOption {
      type = types.str;
      default = "Xresources";
    };
  };
  config = mkIf cfg.enable {
    home.file.".Xresources".source = ./xfiles/. + ("/" + cfg.xresourcesFile);
    home.file.".xinitrc".source = ./xfiles/. + ("/" + cfg.xinitrcFile);
    home.file.".xprofile".source = ./xfiles/. + ("/" + cfg.xprofileFile);

    services.picom = {
      enable = true;
      backend = "glx";
      #vSync = true; # <- Probably don't want this unless you have tearing issues
    };
  };
}


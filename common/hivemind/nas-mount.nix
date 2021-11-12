{ config, pkgs, lib, ... }:

with lib;
let cfg = config.hivemind.nas-mount;
in {
  options = {
    hivemind.nas-mount.enable = mkEnableOption "enable nas-mount mode";
  };
  config = mkIf cfg.enable {
    fileSystems."/mnt/share" = {
      device = "swarm-host:/home/share";
      fsType = "nfs";
      options = [ "user" "noauto" "exec" "x-systemd.automount" ];
    };

    fileSystems."/mnt/volume2" = {
      device = "192.168.199.105:/volume2/storage";
      fsType = "nfs";
      options = [ "user" "noauto" "exec" "x-systemd.automount" ];
    };
  };
}


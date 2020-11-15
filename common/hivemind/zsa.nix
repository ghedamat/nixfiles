{ config, pkgs, lib, ... }:

with lib;
let cfg = config.hivemind.zsa;
in {
  options = { hivemind.zsa.enable = mkEnableOption "enable zsa tools"; };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wally-cli
      (import ../packages/zsa-udev-rules.nix)
    ];

    services.udev.extraRules = ''
          ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", \
          ENV{ID_MM_DEVICE_IGNORE}="1"
      ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", \
          ENV{MTP_NO_PROBE}="1"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", \
          ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
      KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", \
          ATTRS{idProduct}=="04[789B]?", MODE:="0666"
          '';
  };
}


{ config, pkgs, lib, ... }:

with lib;
let cfg = config.hivemind.tailscale;
in {
  options = {
    hivemind.tailscale.enable = mkEnableOption "enable tailscale";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ tailscale ];
    services.tailscale.enable = true;
  };
}

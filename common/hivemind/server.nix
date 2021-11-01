{ config, pkgs, lib, ... }:

with lib;
let cfg = config.hivemind.server;
in {
  options = {
    hivemind.server.enable = mkEnableOption "enable server mode";
    hivemind.server.xserver = mkEnableOption "enable xserver";
    hivemind.server.vmware = mkEnableOption "enable vmware tools";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gnumake git nixopsUnstable ];

    networking.networkmanager.enable = true;
    programs.mosh.enable = true;
    programs.ssh.forwardX11 = true;

    services.sshd.enable = true;
    services.openssh.enable = true;
    services.openssh.forwardX11 = true;
    services.openssh.permitRootLogin = "yes";

    services.xserver = mkIf cfg.xserver {
      enable = true;
      layout = "us";
      libinput.enable = true;
    };

    # enable open-vm-tools for esxi integration
    # TODO enable, blocked on https://github.com/NixOS/nixpkgs/pull/142408
    virtualisation.vmware.guest = mkIf cfg.vmware {
      enable = false;
      headless = true;
    };
  };
}

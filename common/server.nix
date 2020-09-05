{ config, pkgs, lib, ... }:

with lib;
let cfg = config.hivemind.server;
in {
  options = {
    hivemind.server.enable = mkEnableOption "enable server mode";
    hivemind.server.xserver = mkEnableOption "enable xserver";
    hivemind.server.docker = mkEnableOption "enable docker";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gnumake git nixops ];

    networking.networkmanager.enable = true;
    programs.mosh.enable = true;
    programs.ssh.forwardX11 = true;

    services.sshd.enable = true;
    services.openssh.enable = true;
    services.openssh.forwardX11 = true;
    services.openssh.permitRootLogin = "yes";

    # enable open-vm-tools for esxi integration
    virtualisation.vmware.guest.enable = true;
    virtualisation.vmware.guest.headless = true;

    services.xserver = mkIf cfg.xserver {
        enable = true;
        layout = "us";
        libinput.enable = true;
    };

    # docker stuff
    virtualisation.docker = mkIf cfg.docker {
      enable = true;
      enableOnBoot = true;
    };
  };
}

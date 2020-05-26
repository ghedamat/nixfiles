# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware/hive-exsi-mbr-vm.nix
    ./common/base-system.nix
    ./common/server.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/nvme0n1"; # or "nodev" for efi only

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  #networking.interfaces.ens160.useDHCP = true;
  networking.interfaces.ens192.useDHCP = true;
  networking.hostName = "overlord"; # Define your hostname.
  networking.firewall.enable = false;
  networking.extraHosts = ''
    192.168.199.26 esxi.starcraft.local
    192.168.199.33 dnsmasq.starcraft.local

    192.168.199.90 hue.starcraft.local
    192.168.199.66 rando.starcraft.local
    192.168.199.127 outerrim.starcraft.local

    192.168.199.137 ark.starcraft.local

    192.168.199.184 winfan.starcraft.local

    192.168.199.191 es-dev.precisionnutrition.com mobile-es-dev.precisionnutrition.com mobile.es-dev.precisionnutrition.com
    192.168.199.191 lurker.starcraft.local

    192.168.199.180 hivemind.starcraft.local
    192.168.199.192 hydralisk.starcraft.local
    192.168.199.159 ultralisk.starcraft.local
    192.168.199.140 overlord.starcraft.local
    192.168.199.149 nydusworm.starcraft.local
    192.168.199.131 drone.starcraft.local

    192.168.199.170 comsat-station.starcraft.local
    192.168.199.163 mineos.starcraft.local
    192.168.199.177 zergling.starcraft.local
    192.168.199.150 infested-terran.starcraft.local
    192.168.199.135 spawning-pool.starcraft.local
  '';

  services.dnsmasq.enable = true;
  services.dnsmasq.servers = [ "1.1.1.1" "/pnroof.local/192.168.123.47" ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}


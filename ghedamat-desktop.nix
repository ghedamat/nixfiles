{ config, pkgs, lib, ... }:

{
  services.localtime.enable = true;
  time.timeZone = "America/Toronto";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl intel-media-driver ];

  nix.maxJobs = lib.mkDefault 4;

  imports = [
    ./hardware/desktop-i5.nix
    ./common/base-system.nix
    ./common/desktop-i3.nix
    ./common/yubikey.nix
    ./common/dev.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
  ];

  # zsh stuff
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
  programs.autojump.enable = true;


  networking.hostName = "border";
  networking.networkmanager.wifi.macAddress = "preserve";  # Or "random", "stable", "permanent", "00:11:22:33:44:55"
  networking.networkmanager.wifi.powersave = false;
  networking.networkmanager.appendNameservers = [ "192.168.199.133" ];
  #127.0.0.1 es-dev.precisionnutrition.com
  networking.extraHosts =
    ''
    '';

  users.users.ghedamat = {
    isNormalUser = true;
    home = "/home/ghedamat";
    description = "ghedamat";
    extraGroups = [
      "wheel"
      "sudoers"
      "audio"
      "video"
      "disk"
      "networkmanager"
      "plugdev"
      "adbusers"
      "docker"
    ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  ## NEW
  services.openssh.enable = true;

  services.logind.extraConfig = ''
    RuntimeDirectorySize=7.8G
  '';

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}

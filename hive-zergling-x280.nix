let
  hashedPassword = import ./.hashedPassword.nix;
  # Make with mkpasswd (see Makefile)

in { config, pkgs, lib, ... }:

{
  services.localtime.enable = true;
  time.timeZone = "America/Toronto";

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" ];
  boot.blacklistedKernelModules = [ "mei_me" ];
  #options iwlwifi power_save=1 d0i3_disable=0 uapsd_disable=0
  #options i915                fastboot=0 enable_rc6=1 modeset=1 enable_fbc=1 enable_guc_loading=1 enable_guc_submission=1 enable_huc=1 enable_psr=1 disable_power_well=0 semaphores=1 nuclear_pageflip=1  enable_gvt=0 enable_psr=2 
  #options intel_iommu off
  #options intel_idle max_cstate=1
  boot.extraModprobeConfig = ''
    options iwldvm force_cam=0
    options cfg80211 ieee80211_regdom=US
    options snd_hda_intel power_save=1 power_save_controller=Y
  '';

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    libvdpau-va-gl
    vaapiVdpau
    intel-ocl
    intel-media-driver
  ];
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware/thinkpad-x280.nix
    ./hardware/boot-x280.nix
    ./common/base-system.nix
    ./common/desktop-i3.nix
    ./common/yubikey.nix
    ./common/hivemind/dev.nix
    ./common/hivemind/zsa.nix
    ./common/hivemind/nas-mount.nix
  ];

  networking.hostName = "zergling";
  networking.networkmanager.wifi.macAddress =
    "preserve"; # Or "random", "stable", "permanent", "00:11:22:33:44:55"
  networking.networkmanager.wifi.powersave = false;
  networking.networkmanager.enable = true;
  networking.networkmanager.appendNameservers = [ "192.168.199.133" ];
  #127.0.0.1 es-dev.precisionnutrition.com
  networking.extraHosts = ''
    127.0.0.1 local_rails
      '';

  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

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
    hashedPassword = hashedPassword;
    shell = pkgs.zsh;
  };

  services.logind.extraConfig = ''
    RuntimeDirectorySize=7.8G
  '';

  # zsh stuff
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
  programs.autojump.enable = true;

  # hivemind modules
  hivemind.dev = {
    enable = true;
    docker = true;
  };

  hivemind.zsa.enable = true;

  hivemind.nas-mount.enable = true;

  ## stuff to move
  services.redshift.enable = true;
  services.redshift.provider = "geoclue2";
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  # temporary config
  environment.systemPackages = with pkgs; [ direnv nix-direnv steam ];
  # nix options for derivations to persist garbage collection
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  environment.pathsToLink = [ "/share/nix-direnv" ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}

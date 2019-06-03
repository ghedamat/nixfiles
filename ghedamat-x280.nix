let hashedPassword = import ./.hashedPassword.nix; in  # Make with mkpasswd (see Makefile)

{ config, pkgs, lib, ... }:

{
  services.localtime.enable = true;
  time.timeZone = "America/Toronto";

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" ];
  boot.blacklistedKernelModules = [ "mei_me" ];
  #options iwlwifi power_save=1 d0i3_disable=0 uapsd_disable=0
  boot.extraModprobeConfig = ''
     options iwldvm force_cam=0
     options cfg80211 ieee80211_regdom=US
     options snd_hda_intel power_save=1 power_save_controller=Y
  '';

  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl intel-media-driver ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  imports = [
    ./hardware/thinkpad-x280.nix
    ./common/boot.nix
    ./common/desktop-i3.nix
    ./common/yubikey.nix
  ];

  environment.systemPackages = with pkgs; [
    # Desktop
    alsaTools
    arandr
    blueman
    colord
    dunst
    feh
    libnotify
    maim
    openvpn
    pavucontrol
    xclip
    xdotool
    xsel
    xorg.xbacklight

    # Apps
    alacritty
    gnupg
    google-chrome-beta

    # Other
    alsa-firmware

    # mix 
    wget
    (import ./common/vim.nix)
    git
    curl
    ruby
    emacs
    docker
    docker-compose
    nodejs-11_x
    zsh
    keychain
    homesick
    fzf
    autojump
    tmux
    source-code-pro
    silver-searcher
    rxvt_unicode
    xfontsel
  ];

  # zsh stuff
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
  programs.autojump.enable = true;

  networking.hostName = "x280nix";
  networking.networkmanager.wifi.macAddress = "preserve";  # Or "random", "stable", "permanent", "00:11:22:33:44:55"

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
      "adbusers
    "];
    uid = 1000;
    hashedPassword = hashedPassword;
    shell = pkgs.zsh;
  };

  ## NEW
  services.openssh.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}

let
in { config, pkgs, lib, ... }:

{
  services.localtime.enable = true;
  time.timeZone = "America/Toronto";

  boot.kernelPackages = pkgs.linuxPackages_latest;

nixpkgs.config = {
  packageOverrides = pkgs: {
    linux_5_0 = pkgs.linux_5_0.override {
      extraConfig = ''
          B43_SDIO y
          PMIC_OPREGION y
          CHT_WC_PMIC_OPREGION y
          ACPI_I2C_OPREGION y
          I2C y
          I2C_CHT_WC m
          INTEL_SOC_PMIC_CHTWC y
          EXTCON_INTEL_CHT_WC m
          MATOM y
          I2C_DESIGNWARE_BAYTRAIL y
          POWER_RESET y
          PWM y
          PWM_LPSS m
          PWM_LPSS_PCI m
          PWM_LPSS_PLATFORM m
          PWM_SYSFS y
      '';
    };
  };
};

  powerManagement = {
    enable = true;
    powerDownCommands = ''
      rmmod goodix
    '';
    powerUpCommands = ''
      modprobe goodix
    '';
  };

  services.tlp = {
    enable = true;
    extraConfig = ''
      DISK_DEVICES="mmcblk0"
      DISK_IOSCHED="deadline"
      WIFI_PWR_ON_AC=off
      WIFI_PWR_ON_BAT=off
    '';
  };

  services.udev = {
    extraRules = let
      script = pkgs.writeShellScriptBin "enable-bluetooth" ''
        modprobe btusb
        echo "0000 0000" > /sys/bus/usb/drivers/btusb/new_id
      '';
    in
      ''
       SUBSYSTEM=="usb", ATTRS{idVendor}=="0000", ATTRS{idProduct}=="0000", RUN+="${script}/bin/enable-bluetooth"
    '';
  };

   boot = {
    kernelParams = [
      "gpd-pocket-fan.speed_on_ac=0"
    ];
    kernelModules = [ "kvm-intel" ];

    initrd = {
      kernelModules = [
        "intel_agp"
        "pwm-lpss"
        "pwm-lpss-platform" # for brightness control
        "i915"
        "btusb"
      ];
      availableKernelModules = [
        "xhci_pci"
        "dm_mod"
        "btrfs"
        "crc23c"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "sdhci_acpi"
        "rtsx_pci_sdmmc"
      ];
    };
    extraModprobeConfig = ''
      options i915 enable_fbc=1 enable_rc6=1 modeset=1
    '';
  };
 boot.loader.systemd-boot.enable = true;

  networking.hostName = "baneling";

  i18n.consoleFont = "latarcyrheb-sun32";

  environment.variables = {
    MOZ_USE_XINPUT2 = "1";
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  nixpkgs.config.allowUnfree = true;


  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  imports =
    [ <nixpkgs/nixos/modules/hardware/network/broadcom-43xx.nix>
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ./common/base-system.nix
    ./common/desktop-i3.nix
    ./common/yubikey.nix
    ./common/dev.nix
    ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/81f060a3-9bcb-4e0b-b625-187f91a88706";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/791D-CD20";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/3fe7318e-0603-48f7-a5a6-3a8e0abb7ca1"; }
    ];

  nix.maxJobs = lib.mkDefault 4;

  # zsh stuff
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
  programs.autojump.enable = true;

  networking.networkmanager.wifi.macAddress = "preserve"; # Or "random", "stable", "permanent", "00:11:22:33:44:55"
  networking.networkmanager.wifi.powersave = false;
  networking.networkmanager.enable = true;
  networking.networkmanager.appendNameservers = [ "192.168.199.133" ];
  #127.0.0.1 es-dev.precisionnutrition.com
  networking.extraHosts = ''
    127.0.0.1 local_rails
      '';

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
    shell = pkgs.zsh;
  };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true; # see https://github.com/shazow/nixfiles/commit/1439b454cd3ccbb60e5bd92b09d9d3b703b62208


  services.xserver = {
    dpi = 168;
    deviceSection = ''
      Option      "AccelMethod"     "sna"
      Option      "TearFree"        "true"
      Option      "DRI"             "3"
    '';
    xrandrHeads = [{
      output= "DSI-1";
      primary = true;
      monitorConfig = ''Option "Rotate" "right"'';
    }];
    inputClassSections = [
    ''
      Identifier  "calibration"
      MatchProduct    "Goodix Capacitive TouchScreen"
      Option  "TransformationMatrix" "0 1 0 -1 0 1 0 0 1"
    ''
    ''
      Identifier "GPD trackpoint"
      MatchProduct "SINO WEALTH Gaming Keyboard"
      MatchIsPointer "on"
      Driver "libinput"
      Option "MiddleEmulation" "1"
      Option "ScrollButton" "3"
      Option "ScrollMethod" "button"
    ''];
  };

  services.xserver.libinput = {
    enable = true;
    disableWhileTyping = true;
    accelSpeed = "0.25";
    clickMethod = "clickfinger";
  };

  ## NEW
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  services.logind.extraConfig = ''
    RuntimeDirectorySize=7.8G
  '';

  #services.redshift.enable = true;
  #services.redshift.provider = "geoclue2";

  #environment.systemPackages = with pkgs; [ direnv  nix-direnv ];
  # nix options for derivations to persist garbage collection
  #nix.extraOptions = ''
  #  keep-outputs = true
  #  keep-derivations = true
  #'';
  #environment.pathsToLink = [
  #  "/share/nix-direnv"
  #];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}


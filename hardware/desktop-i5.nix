{ config, lib, pkgs, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "firewire_ohci" "usbhid" "usb_storage" "sd_mod" ];
  boot.extraModulePackages = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.blacklistedKernelModules = [ "mei_me" ];
  boot.extraModprobeConfig = ''
     options snd_hda_intel power_save=1 power_save_controller=Y
  '';

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  services.xserver.videoDrivers = [ "nvidia" ];

  services.xserver.deviceSection = ''
    Option "TearFree" "true"
    Option "DRI" "2"
  '';

  services.xserver.screenSection = ''
    Monitor        "Monitor0"
    DefaultDepth    24
    Option         "Stereo" "0"
    Option         "nvidiaXineramaInfoOrder" "DFP-1"
    Option         "metamodes" "DVI-D-0: nvidia-auto-select +3840+0, HDMI-0: nvidia-auto-select +1920+1080, DP-2: nvidia-auto-select +0+0, DP-0: 1920x1080 +1920+0; DVI-D-0: nvidia-auto-select +0+0, DP-0: nvidia-auto-select +0+0; DVI-D-0: 1920x1080 +0+0, DP-0: nvidia-auto-select +0+0; DVI-D-0: 1680x1050 +0+0, DP-0: nvidia-auto-select +0+0; DVI-D-0: 1600x1200 +0+0, DP-0: nvidia-auto-select +0+0; DVI-D-0: 1280x1024 +0+0, DP-0: nvidia-auto-select +0+0; DVI-D-0: 1280x960 +0+0, DP-0: nvidia-auto-select +0+0; DVI-D-0: 1024x768 +0+0, DP-0: nvidia-auto-select +0+0; DVI-D-0: 800x600 +0+0, DP-0: nvidia-auto-select +0+0; DVI-D-0: 640x480 +0+0, DP-0: nvidia-auto-select +0+0; DVI-D-0: nvidia-auto-select +0+0 {viewportin=1440x900}, DP-0: nvidia-auto-select +0+0; DVI-D-0: nvidia-auto-select +0+0 {viewportin=1366x768, viewportout=1920x1079+0+60}, DP-0: nvidia-auto-select +0+0"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    SubSection     "Display"
        Depth       24
    EndSubSection
  '';
}

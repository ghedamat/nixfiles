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
  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
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
    Option         "metamodes" "DVI-D-0: nvidia-auto-select +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, HDMI-0: nvidia-auto-select +1920+1080 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-0: 1920x1080 +1920+0; DVI-D-0: nvidia-auto-select +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-0: nvidia-auto-select +0+0; DVI-D-0: 1920x1080 +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-0: nvidia-auto-select +0+0; DVI-D-0: 1680x1050 +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-0: nvidia-auto-select +0+0; DVI-D-0: 1600x1200 +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-0: nvidia-auto-select +0+0"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"
    SubSection     "Display"
        Depth       24
    EndSubSection
  '';
}

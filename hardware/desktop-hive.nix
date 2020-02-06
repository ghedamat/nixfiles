{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ahci" "virtio_pci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0290cf89-14a2-486e-8a96-b09e3087727a";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/CF3D-29CA";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/001d3c55-7c06-474e-8e20-e0bf9a8bf1a1"; }
    ];

  nix.maxJobs = lib.mkDefault 16;

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
    Option         "metamodes" "HDMI-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: nvidia-auto-select +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-0: 1920x1080 +1920+0, HDMI-1: nvidia-auto-select +1920+1080; DP-0: nvidia-auto-select +0+0, HDMI-1: nvidia-auto-select +3840+0"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"
    SubSection     "Display"
        Depth       24
    EndSubSection
  '';

  environment.systemPackages = with pkgs; [
    libv4l
    v4l-utils
    xawtv
  ];

  hardware.logitech.enableGraphical = true;
}

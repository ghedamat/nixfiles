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
    #Option         "metamodes" "HDMI-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: nvidia-auto-select +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-0: 1920x1080 +1920+0, HDMI-1: nvidia-auto-select +1920+1080; DP-0: nvidia-auto-select +0+0, HDMI-1: nvidia-auto-select +3840+0"
    #Option         "metamodes" "HDMI-0: nvidia-auto-select +0+0 {rotation=left, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: nvidia-auto-select +3120+0 {rotation=right, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-0: 1920x1080 +1200+420, HDMI-1: nvidia-auto-select +1200+1500"
    Option         "metamodes" "HDMI-0: nvidia-auto-select +0+0 {rotation=left, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: nvidia-auto-select +3760+0 {rotation=right, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, HDMI-1: nvidia-auto-select +1520+1680, DP-0: 2560x1440_144 +1200+240; HDMI-0: nvidia-auto-select +0+0, DP-0: nvidia-auto-select +1200+0; HDMI-0: 1920x1200_60_0 +0+0, DP-0: nvidia-auto-select +1200+0; HDMI-0: 1920x1080 +0+0, DP-0: nvidia-auto-select +1200+0; HDMI-0: 1920x1080_60_0 +0+0, DP-0: nvidia-auto-select +1200+0; HDMI-0: 1920x1080_50 +0+0, DP-0: nvidia-auto-select +1200+0; HDMI-0: 1920x1080_30 +0+0, DP-0: nvidia-auto-select +1200+0; HDMI-0: 1920x1080_25 +0+0, DP-0: nvidia-auto-select +1200+0; HDMI-0: 1920x1080_24 +0+0, DP-0: nvidia-auto-select +1200+0; HDMI-0: 1600x1200 +0+0, DP-0: nvidia-auto-select +1200+0"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"
    Option                 "DPI" "96 x 96"
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
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.configFile = pkgs.runCommand "default.pa" {} ''
	  sed 's/module-udev-detect$/module-udev-detect tsched=0/' \
	  ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
	  '';
}

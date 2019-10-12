{ config, lib, pkgs, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "ehci_pci" "xhci_pci" "nvme" "sr_mod" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [ "mei_me" ];
  boot.extraModprobeConfig = ''
     options snd_hda_intel power_save=1 power_save_controller=Y
  '';

  fileSystems."/" =
    # TODO fix
    { device = "/dev/disk/by-uuid/5fb149e7-8b75-488a-aef2-ff38a6afed32";
      fsType = "ext4";
    };

  services.xserver.videoDrivers = [ "nvidia" ];

  nix.maxJobs = lib.mkDefault 1;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # TODO fix
  boot.loader.grub.device = "/dev/nvme0n1"; # or "nodev" for efi only
}

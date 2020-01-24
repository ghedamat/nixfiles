{ config, pkgs, lib, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true; # see https://github.com/shazow/nixfiles/commit/1439b454cd3ccbb60e5bd92b09d9d3b703b62208


  # Backport from <nixos-hardware/lenovo/thinkpad/x1/6th-gen/QHD>
  boot.kernelModules = [ "acpi_call" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];


  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.deviceSection = ''
    Option "TearFree" "true"
    Option "DRI" "3"
    Option "Backlight" "intel_backlight"
  '';

  services.xserver.libinput = {
    enable = true;
    disableWhileTyping = true;
    accelSpeed = "0.25";
    clickMethod = "clickfinger";
  };

  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    CPU_SCALING_GOVERNOR_ON_AC=ondemand
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
    START_CHARGE_THRESH_BAT0=75
    STOP_CHARGE_THRESH_BAT0=85
    DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"
    DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE="bluetooth"
  '';

  # Firmware updating
  services.fwupd.enable = true;

  # Disable the "throttling bug fix" -_- https://github.com/NixOS/nixos-hardware/blob/master/common/pc/laptop/cpu-throttling-bug.nix
  systemd.timers.cpu-throttling.enable = lib.mkForce false;
  systemd.services.cpu-throttling.enable = lib.mkForce false;
}

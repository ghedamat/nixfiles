{ config, pkgs, lib, ... }:

{
  imports = [
    ./desktop.nix
  ];

  services.xserver = {
    displayManager.startx.enable = true;
    displayManager.defaultSession = "none+i3";  # We startx in our home.nix

    windowManager.i3.enable = true;
  };

  environment.systemPackages = with pkgs; [
    clipmenu
    clipnotify
    i3lock
    i3status-rust
    networkmanagerapplet
    pcmanfm
    rofi
    xss-lock
    polybar
    i3status-rust

    compton
  ];

  # build polybar with i3 support
  # does not seem to build w/out pulseaudio support as well
  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
        pulseSupport = true;
      };
    };
  };

  services.clipmenu.enable = true;
  # Based on https://github.com/cdown/clipmenu/blob/develop/init/clipmenud.service
  systemd.user.services.clipmenud = {
    description = "Clipmenu daemon";
    serviceConfig =  {
      Type = "simple";
      NoNewPrivileges = true;
      ProtectControlGroups = true;
      ProtectKernelTunables = true;
      RestrictRealtime = true;
      MemoryDenyWriteExecute = true;
    };
    wantedBy = [ "default.target" ];
    environment = {
      DISPLAY = ":0";
    };
    path = [ pkgs.clipmenu ];
    script = ''
      ${pkgs.clipmenu}/bin/clipmenud
    '';
  };
}

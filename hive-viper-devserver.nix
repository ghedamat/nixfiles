# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware/hive-dev-template.nix
    ./common/base-system.nix
    ./common/hivemind/dev.nix
    ./common/hivemind/server.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "viper"; # Define your hostname.
  networking.firewall.enable = false;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ qemu google-chrome ];

  users.users.ghedamat = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # zsh stuff
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh

  programs.autojump.enable = true;

  # increase /run/user/1000 tmpfs size
  services.logind.extraConfig = ''
    RuntimeDirectorySize=7.8G
  '';

  services.keybase.enable = true;

  services.qemuGuest.enable = true;

  xdg.portal.enable = true;
  services.flatpak.enable = true;

  # hivemind config
  hivemind = {
    server = {
      enable = true;
      xserver = true;
    };
    dev = {
      enable = true;
      docker = true;
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}

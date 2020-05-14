{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnumake
    git
    nixops
  ];

  networking.networkmanager.enable = true;
  services.sshd.enable = true;
  programs.mosh.enable = true;
  programs.ssh.forwardX11 = true;
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;
  services.openssh.permitRootLogin = "yes";

  # enable open-vm-tools for esxi integration
  virtualisation.vmware.guest.enable = true;
  virtualisation.vmware.guest.headless = true;

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;
    displayManager.startx.enable = true;
    displayManager.defaultSession = "none+i3";  # We startx in our home.nix

    windowManager.i3.enable = true;
  };
}

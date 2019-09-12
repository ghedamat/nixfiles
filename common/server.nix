{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    gnumake
    git
  ];

  networking.networkmanager.enable = true;
  services.sshd.enable = true;
  programs.mosh.enable = true;
  programs.ssh.forwardX11 = true;
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;
  };
}

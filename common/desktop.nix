{ pkgs, ... }:
{

  # FIXME: Is this necessary?
  system.copySystemConfiguration = true;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      neovim = pkgs.neovim.override {
        #vimAlias = true;
      };
    };
  };

  # required by https://github.com/rycee/home-manager/blob/master/FAQ.md#why-do-i-get-an-error-message-about-cadesrtdconf
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  # Desktop environment agnostic packages.
  environment.systemPackages = with pkgs; [
    acpi
    bind # nslookup etc
    binutils-unwrapped
    dmidecode
    fd
    git
    gnumake
    htop
    inetutils
    lm_sensors
    mkpasswd
    neovim
    p7zip
    patchelf
    pciutils
    powertop
    psmisc
    ripgrep
    sysstat
    tmux
    tree
    unzip
    imagemagick
    lxrandr
    pcmanfm
    gotop
    openvpn
    bc

    # Wireless
    bluez
    iw # wireless tooling
    crda # wireless regulatory agent
    wireless-regdb

    # comm
    tdesktop
    slack
    discord

    # misc
    calibre
    google-chrome-beta
    firefox-beta-bin

    # Desktop
    alsaTools
    libpulseaudio
    arandr
    blueman
    colord
    dunst
    feh
    libnotify
    maim
    openvpn
    pavucontrol
    xclip
    xdotool
    xsel
    xorg.xbacklight
    rdesktop
    x2goclient
    tightvnc
    tigervnc

    # Apps
    alacritty
    gnupg

    # Other
    alsa-firmware

    # mix
    rxvt_unicode
    xfontsel

    # tether
    libimobiledevice
  ];

  environment.shellInit = ''
    export EDITOR=nvim
    export VISUAL=nvim
  '';

  fonts = {
    enableFontDir = true;
    fontconfig.enable= true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
    emojione
    terminus
      nerdfonts  # Includes font-awesome, material-icons, powerline-fonts
      fira
      fira-code
      fira-mono
      cantarell_fonts
      corefonts # Microsoft free fonts
      gentium
      inconsolata
      noto-fonts
      opensans-ttf
      freefont_ttf
      liberation_ttf
      xorg.fontmiscmisc
      ubuntu_font_family
      dejavu_fonts
      powerline-fonts
      font-awesome_5
    ];
  };

  i18n = {
    consoleFont = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  networking.firewall.allowedTCPPorts = [2323 3000];
  networking.firewall.allowedUDPPorts = [2323 3000];

  hardware.sane.enable = true;
  hardware.pulseaudio = {
    enable = true;
    # Need full for bluetooth support
    package = pkgs.pulseaudioFull;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };

  programs.light.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brgenml1lpr pkgs.brgenml1cupswrapper];

  #services.dnsmasq.enable = true;
  #services.dnsmasq.servers = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];

  # Gaming (Steam)
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  sound.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;
  };

  services.usbmuxd.enable = true;
}

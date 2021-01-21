# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware/hive-dev-template.nix
    ./common/base-system.nix
    ./common/hivemind.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ultralisk"; # Define your hostname.
  networking.firewall.enable = false;
  networking.useDHCP = false;
  networking.interfaces.enp6s18.useDHCP = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ qemu ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ghedamat = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # zsh stuff
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.autojump.enable = true;

  programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh

  # increase /run/user/1000 tmpfs size
  services.logind.extraConfig = ''
    RuntimeDirectorySize=7.8G
  '';

  services.qemuGuest.enable = true;

  # hivemind config
  hivemind.server.enable = true;

  # postgres config
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_11;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 11 ''
      local all all trust
      host all all 192.168.199.1/24 trust
    '';
    settings = {
      shared_buffers = "12GB";
      work_mem = "16MB";
      maintenance_work_mem = "256MB";
      dynamic_shared_memory_type = "posix";
      effective_io_concurrency = 1000;
      max_worker_processes = 16;
      max_parallel_maintenance_workers = 4;
      max_parallel_workers_per_gather = 4;
      max_parallel_workers = 16;
      max_wal_size = "1GB";
      min_wal_size = "80MB";
      checkpoint_completion_target = 0.9;

      enable_partitionwise_join = "on";
      enable_partitionwise_aggregate = "on";
      seq_page_cost = 1.0;
      random_page_cost = 1.0;
      effective_cache_size = "20GB";

      #log_line_prefix = "%m [%p] %q%u@%d ";
      log_timezone = "Etc/UTC";

      cluster_name = "11/main";
      stats_temp_directory = "/var/run/postgresql/12-main.pg_stat_tmp";

      datestyle = "iso, mdy";
      timezone = "Etc/UTC";
      lc_messages = "en_US.UTF-8";
      lc_monetary = "en_US.UTF-8";
      lc_numeric = "en_US.UTF-8";
      lc_time = "en_US.UTF-8";

      default_text_search_config = "pg_catalog.english";
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}

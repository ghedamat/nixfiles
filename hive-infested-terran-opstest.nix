# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  downloadScript = pkgs.writeShellScriptBin "download-es" ''
    source ~/.noe-aws-prod-creds
    eval $(${pkgs.awscli}/bin/aws ecr get-login --region us-east-2 --no-include-email)
    ${pkgs.docker}/bin/docker pull 483218180663.dkr.ecr.us-east-2.amazonaws.com/precisionnutrition-production-eternal-sledgehammer/web:$1
    ${pkgs.docker}/bin/docker image tag 483218180663.dkr.ecr.us-east-2.amazonaws.com/precisionnutrition-production-eternal-sledgehammer/web:$1 es-web:$1
  '';
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware/hive-dev-template.nix
    ./common/base-system.nix
    ./common/server.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    qemu

    awscli

    downloadScript
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "infested-terran"; # Define your hostname.
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
  users.users.deployer = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.bash;
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

  # postgres config
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_11;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 11 ''
      local all all trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE USER admin WITH PASSWORD 'password';
      ALTER USER admin WITH SUPERUSER;
    '';
  };

  virtualisation.docker.enable = true;

  docker-containers.nginx = {
    image = "nginx-container";
    imageFile = pkgs.dockerTools.examples.nginx;
    ports = [ "8181:80" ];
  };

  docker-containers.mailcatcher = {
    image = "mailcatcher";
    imageFile = pkgs.dockerTools.pullImage {
      imageName = "schickling/mailcatcher";
      imageDigest =
        "sha256:994aba62ace1a4442e796041b6c6c96aed5eca9de4a6584f3d5d716f1d7549ed";
      sha256 = "1gi1d1gnl50ahv5mwz4dqzqnydbv3f5z7mvxl202jpqdmj2skpdz";
      finalImageTag = "latest";
      finalImageName = "mailcatcher";
    };

    ports = [ "1080:1080" "25:25" ];
  };

  docker-containers.redis-main = {
    image = "redis";
    imageFile = pkgs.dockerTools.pullImage {
      imageName = "redis";
      imageDigest =
        "sha256:2e03fdd159f4a08d2165ca1c92adde438ae4e3e6b0f74322ce013a78ee81c88d";
      sha256 = "0zjr44w5fakm7x0ljxy7fczk0wm4bq46dzq87xzp88n6fbakhi81";
      finalImageTag = "latest";
      finalImageName = "redis";
    };

    ports = [ "6379:6379" ];
    volumes = [ "redis_main:/data" ];
  };

  docker-containers.redis-cache = {
    image = "redis";
    imageFile = pkgs.dockerTools.pullImage {
      imageName = "redis";
      imageDigest =
        "sha256:2e03fdd159f4a08d2165ca1c92adde438ae4e3e6b0f74322ce013a78ee81c88d";
      sha256 = "0zjr44w5fakm7x0ljxy7fczk0wm4bq46dzq87xzp88n6fbakhi81";
      finalImageTag = "latest";
      finalImageName = "redis";
    };

    ports = [ "6666:6666" ];
    volumes = [ "redis_cache:/data" ];
  };

  systemd.services.es-web = {
    description = "es-web";
    wantedBy = [ "multi-user.target" ];
    after = [ "docker.service" "docker.socket" ];
    requires = [ "docker.service" "docker.socket" ];
    script = ''
      exec ${pkgs.docker}/bin/docker run \
          --rm \
          --name=es-web \
          --network=host \
          --env-file=/home/deployer/es-env.list \
          es-web:latest \
          "$@"
    '';
    scriptArgs = pkgs.lib.concatStringsSep " " [ ];
    #preStop = "${pkgs.docker}/bin/docker stop prometheus";
    #reload = "${pkgs.docker}/bin/docker restart prometheus";
    serviceConfig = {
      ExecStartPre = [
        "-${pkgs.docker}/bin/docker rm -f es-web"
        "-${pkgs.coreutils}/bin/touch /home/deployer/es-env.list"
      ];
      ExecStopPost = "-${pkgs.docker}/bin/docker rm -f es-web";
      TimeoutStartSec = 0;
      TimeoutStopSec = 120;
      Restart = "on-success";
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}

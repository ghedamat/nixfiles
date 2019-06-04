{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    gnumake
    awscli
    jq

    docker
    docker-compose

    ruby

    yarn
    nodejs-11_x
  ];

  # docker stuff
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
}

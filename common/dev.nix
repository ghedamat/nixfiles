{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    gnumake
    awscli
    jq
    terraform

    docker
    docker-compose

    ruby

    yarn
    nodejs-11_x

    heroku
  ];

  # docker stuff
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
}

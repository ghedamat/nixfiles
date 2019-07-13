{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    gnumake
    awscli
    jq

    terraform

    chefdk

    docker
    docker-compose

    ruby
    bundix

    yarn
    nodejs-11_x

    electron

    heroku

    meld

    google-chrome
    docker
    docker-compose
  ];

  # docker stuff
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
}

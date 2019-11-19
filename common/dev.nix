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
    nodejs-10_x

    electron

    heroku

    meld

    google-chrome
    docker
    docker-compose

    solargraph
    nodePackages.eslint
    ocamlPackages.reason

    fd

    rustup

    tmate

    bc
  ];

  # docker stuff
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
}

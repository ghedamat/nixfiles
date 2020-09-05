{ config, pkgs, lib, ... }:

with lib;
let cfg = config.hivemind.dev;
in {
  options = {
    hivemind.dev.enable = mkEnableOption "enable dev packages";
    hivemind.dev.docker = mkEnableOption "enable docker";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      awscli
      bc
      bundix
      devtodo
      docker
      docker-compose
      electron
      fd
      firefox
      git
      git-up
      gnumake
      heroku
      jq
      meld
      nodejs-10_x
      nodePackages.eslint
      ocamlPackages.reason
      ruby
      rustup
      solargraph
      terraform
      tmate
      yarn
    ];

    # docker stuff
    virtualisation.docker = mkIf cfg.docker {
      enable = true;
      enableOnBoot = true;
    };
  };
}

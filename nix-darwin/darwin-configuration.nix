{ config, pkgs, ... }: {
  system.primaryUser = "ghedamat";

  # System packages
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    neovim
  ];

  # Enable nix flakes
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "ghedamat" ];
    };
  };

 ids.gids.nixbld = 350;
  # Required for nix-darwin
  system.stateVersion = 4;
}

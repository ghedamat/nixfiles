{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.programs.vsliveshare;
in {
  options = {
    ghedamat.programs.vsliveshare.enable = mkEnableOption "enable vsliveshare";
  };

  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vsliveshare/tarball/master"}/modules/vsliveshare/home.nix"
  ];

  config = mkIf cfg.enable {
    services.vsliveshare = {
      enable = true;
      extensionsDir = "$HOME/.vscode/extensions";
      nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/61cc1f0dc07c2f786e0acfd07444548486f4153b";
    };
  };
}

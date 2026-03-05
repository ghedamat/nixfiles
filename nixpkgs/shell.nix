# Simple flake-compatible shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "home-manager-shell";

  buildInputs = with pkgs; [
    # Basic tools for managing the configuration
    git
    vim
  ];

  shellHook = ''
    echo "Home Manager development shell"
    export HOME_MANAGER_CONFIG="./home.nix"
  '';
}

{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.programs.vsliveshare;
in {
  options = {
    ghedamat.programs.vsliveshare.enable = mkEnableOption "enable vsliveshare";
  };

  # Temporarily disabled due to flake compatibility issues
  # imports = [ ];

  config = mkIf cfg.enable {
    # VSLiveShare disabled - requires proper hashes for flake compatibility
    warnings = [ "VSLiveShare is temporarily disabled due to flake compatibility issues" ];
  };
}

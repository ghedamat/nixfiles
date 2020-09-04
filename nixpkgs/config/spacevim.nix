{ config, pkgs, lib, ... }:

with lib;
let cfg = config.ghedamat.spacevim;
in {
  options = { ghedamat.spacevim.enable = mkEnableOption "enable spacevim"; };
  config = mkIf cfg.enable {
    home.file.".SpaceVim.d/init.toml".source = ./spacevim/init.toml;
    home.file.".SpaceVim.d/autoload/myspacevim.vim".source =
      ./spacevim/autoload/myspacevim.vim;
    home.file.".SpaceVim/coc-settings.json".source =
      ./spacevim/plugin/coc-settings.json;
  };
}

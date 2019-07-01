{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.file.".config/i3/config".source = config/i3/config;
  home.file.".config/i3/status.toml".source = config/i3/status.toml;
  home.file.".tmux.conf".source = config/tmux.conf;
  home.file.".xinitrc".source = config/X/xinitrc;

  programs.git = {
    enable = true;
    userName = "Mattia Gheda";
    userEmail = "ghedamat@gmail.com";
    aliases = {
      st = "status";
      s = "status --short";
      ci = "commit";
      br = "branch";
      co = "checkout";
      ff = "merge --ff-only";
      df = "diff";
      lg = "log -p";
      edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; emacs `f`";
      add-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; git add `f`";
      clone = "clone --recursive";
    };
    extraConfig = {
      core = {
        editor = "vim";
        whitespace = "trailing-space,space-before-tab";
        excludesfile = "/home/ghedamat/.gitignore_global";
      };
      push = {
        default = "tracking";
      };
      merge = {
        keepBackup = false;
        tool = "custom";
      };
      github = {
        user = "ghedamat";
      };
      color = {
        branch = "auto";
        diff = "auto";
        status = "auto";
      };
      "color \"branch\"" = {
        current = "yellow reverse";
        local = "yellow";
        remote = "green";
      };
      "color \"diff\"" = {
        meta = "yellow bold";
        frag = "magenta bold";
        old = "red bold";
        new = "green bold";
      };
      "color \"status\"" = {
        added = "yellow";
        changed = "green";
        untracked = "cyan";
      };
    };
  };

  #gtk = {
  #  enable = true;
  #  theme = {
  #    package = pkgs.theme-vertex;
  #    name = "Vertex-Dark";
  #  };
  #  iconTheme = {
  #    package = pkgs.tango-icon-theme;
  #    name = "Tango";
  #  };
  #};

}

{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.bash = {
    enable = true;
    enableAutojump = true;
    profileExtra = ''
    . /Users/ghedamat/.nix-profile/etc/profile.d/nix.sh
    '';
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "rbenv"
      ];
    };
    profileExtra = ''
    . /Users/ghedamat/.nix-profile/etc/profile.d/nix.sh
    '';
    initExtra = ''
    eval `keychain --eval --agents ssh id_rsa 2018_id_rsa`
    source "$(fzf-share)/key-bindings.zsh"
    '';
  };

  home.packages = with pkgs; [
    vscode
    homesick
    (import ./../common/neovim.nix)
    fzf
  ];

  imports = [
    ./config/tmux.conf.nix
  ];

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
}

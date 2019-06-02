with import <nixpkgs> {};

vim_configurable.customize {
      name = "vim";
      vimrcConfig.customRC = ''
        syntax on
	set tabstop=2
	set expandtab
      '';

        vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
    vimrcConfig.vam.pluginDictionaries = [
        { names = [
            "Syntastic"
            "vim-nix"
        ]; }
    ];
    }

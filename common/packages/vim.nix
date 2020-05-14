with import <nixpkgs> { };

vim_configurable.customize {
  name = "vim";
  vimrcConfig.customRC = ''
    syntax on
    set tabstop=2
    set expandtab
    nnoremap <silent> <F9> :NERDTree<CR>
    let mapleader=","
    let maplocalleader="\\"
    nnoremap <leader><leader> <c-^>
    set backspace=indent,eol,start
  '';

  vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
  vimrcConfig.vam.pluginDictionaries =
    [{ names = [ "Syntastic" "vim-nix" "nerdtree" "vimproc-vim" ]; }];
}

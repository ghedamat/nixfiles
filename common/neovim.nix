with import <nixpkgs> {};

neovim.override {
  withNodeJs = true;
  withRuby = true;
  withPython = true;
}


with import <nixpkgs> { };
let
  pname = "exist-to-obisidian";
  version = "0.0.1";

in stdenv.mkDerivation {
  inherit pname version;

  buildInputs = [ makeWrapper ];

  script = ./exist-to-obsidian/script.sh;

  buildCommand = ''
    mkdir -p $out/bin
    install -Dm755 $script $out/bin/exist-to-obsidian
    wrapProgram $out/bin/exist-to-obsidian --prefix PATH : ${
      lib.makeBinPath [ jq ]
    }
  '';
}


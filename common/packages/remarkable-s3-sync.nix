with import <nixpkgs> { };
let
  pname = "remarkable-s3-sync";
  version = "0.0.1";
  mach-nix = import (builtins.fetchGit {
    url = "https://github.com/DavHau/mach-nix/";
    ref = "2.0.0";
  });

  customPython = mach-nix.mkPython {
    python = python38;
    requirements = ''
      pymupdf
      shapely
          '';
  };
in stdenv.mkDerivation {
  inherit pname version;

  buildInputs = [ makeWrapper ];

  rM2svg = ./remarkable-s3-sync/rM2svg;
  script = ./remarkable-s3-sync/script.sh;

  buildCommand = ''
    mkdir -p $out/bin
    cp $rM2svg $out/bin/rM2svg
    install -Dm755 $script $out/bin/remarkable-s3-sync
    wrapProgram $out/bin/remarkable-s3-sync --prefix PATH : ${
      lib.makeBinPath [ customPython imagemagick awscli2 bash ]
    }
    wrapProgram $out/bin/rM2svg --prefix PATH : ${
      lib.makeBinPath [ customPython ]
    }
  '';
}

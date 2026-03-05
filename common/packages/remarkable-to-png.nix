{ pkgs }:

with pkgs;
let
  pname = "remarkable-to-png";
  version = "0.0.1";
  # Temporarily disabled - fetchFromGitHub requires real hash in flake mode
  mach-nix = throw "remarkable-to-png package disabled due to flake compatibility";

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

  rM2svg = ./remarkable-to-png/rM2svg;
  script = ./remarkable-to-png/script.sh;
  rsync = ./remarkable-to-png/rsync-remarkable.sh;

  buildCommand = ''
    mkdir -p $out/bin
    cp $rM2svg $out/bin/rM2svg
    install -Dm755 $rsync $out/bin/rsync-remarkable
    install -Dm755 $script $out/bin/remarkable-to-png
    wrapProgram $out/bin/remarkable-to-png --prefix PATH : ${
      lib.makeBinPath [ customPython imagemagick awscli2 bash ]
    }
    wrapProgram $out/bin/rM2svg --prefix PATH : ${
      lib.makeBinPath [ customPython ]
    }
  '';
}

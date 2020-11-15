# taken from https://github.com/NixOS/nixpkgs/pull/91203/files
with import <nixpkgs> { };

stdenv.mkDerivation {
  pname = "zsa-udev-rules";
  version = "unstable-2020-06-20";

  # TODO: use version and source from nixpkgs/pkgs/development/tools/wally-cli/default.nix after next release
  src = fetchFromGitHub {
    owner = "zsa";
    repo = "wally";
    rev = "39ada98c490156afc8dd14f7efe2bf9cbf200361";
    sha256 = "1nxral952sfdsjrfj8p22873zs89lwswlip4i9xv4a32r368h627";
  };

  # it only installs files
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    mkdir -p $out/lib/udev/rules.d
    cp dist/linux64/50-oryx.rules $out/lib/udev/rules.d/
    cp dist/linux64/50-wally.rules $out/lib/udev/rules.d/
  '';

  meta = with stdenv.lib; {
    description = "udev rules for ZSA devices";
    license = licenses.mit;
    maintainers = with maintainers; [ davidak ];
    platforms = platforms.linux;
    homepage =
      "https://github.com/zsa/wally/wiki/Linux-install#2-create-a-udev-rule-file";
  };
}

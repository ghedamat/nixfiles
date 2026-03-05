{ pkgs }:

with pkgs;
let
  version = "0.12.19";
  pname = "obsidian-appimage";
  name = "${pname}-${version}";

  plat = {
    i386-linux = "i386";
    x86_64-linux = "x86_64";
  }.${stdenv.hostPlatform.system};

  sha256 = {
    i386-linux = "0v2nsis6vb1lnhmjd28vrfxqwwpycv02j0nvjlfzcgj4b3400j7a";
    x86_64-linux = "15pwmkjg43i9ps9pq3qlwli2qa781fji4dyprp3lc5w01v2500dg";
  }.${stdenv.hostPlatform.system};

  xdg_dirs = builtins.concatStringsSep ":"
    [ "${gtk3}/share/gsettings-schemas/${gtk3.name}" ];

  src = fetchurl {
    url =
      "https://github.com/obsidianmd/obsidian-releases/releases/download/v0.12.19/Obsidian-0.12.19.AppImage";
    inherit sha256;
  };

  appimageContents = appimageTools.extractType2 { inherit name src; };

  nativeBuildInputs = [ autoPatchelfHook desktop-file-utils ];

in appimageTools.wrapType2 rec {
  inherit name src;

  extraPkgs = pkgs:
    with pkgs; [
      libsecret
      wrapGAppsHook
      gtk3
      hicolor-icon-theme
    ];

  extraInstallCommands = ''
    # directory in /nix/store so readonly
    cp -r  ${appimageContents}/* $out
    cd $out
    chmod -R +w $out
    mv $out/bin/${name} $out/bin/${pname}
    # fixup and install desktop file
    #${desktop-file-utils}/bin/desktop-file-install --dir $out/share/applications \
    #  --set-key Exec --set-value ${pname} obidian.desktop
    rm usr/lib/* AppRun obsidian.desktop .so*
  '';

  profile = ''
    export XDG_DATA_DIRS="${xdg_dirs}''${XDG_DATA_DIRS:+:"$XDG_DATA_DIRS"}"
  '';

  meta = with lib; {
    description = "obsidian app image";
    longDescription = "";
    homepage = "https://obsidianmd.org";
    license = licenses.agpl3;
    platforms = [ "i386-linux" "x86_64-linux" ];
  };
}


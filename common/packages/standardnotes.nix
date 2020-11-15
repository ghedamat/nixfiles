with import <nixpkgs> { };
let
  version = "3.5.6";
  pname = "standardnotes";
  name = "${pname}-${version}";

  plat = {
    i386-linux = "i386";
    x86_64-linux = "x86_64";
  }.${stdenv.hostPlatform.system};

  sha256 = {
    i386-linux = "0v2nsis6vb1lnhmjd28vrfxqwwpycv02j0nvjlfzcgj4b3400j7a";
    x86_64-linux = "17102ni3b9c1bqsz81mwkdwl6g46is0syxygp6wn3c2p3bxbm6vd";
  }.${stdenv.hostPlatform.system};

  xdg_dirs = builtins.concatStringsSep ":"
    [ "${gtk3}/share/gsettings-schemas/${gtk3.name}" ];

  src = fetchurl {
    url =
      "https://github.com/standardnotes/desktop/releases/download/v${version}/standard-notes-${version}-linux-${plat}.AppImage";
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
    ${desktop-file-utils}/bin/desktop-file-install --dir $out/share/applications \
      --set-key Exec --set-value ${pname} standard-notes.desktop
    rm usr/lib/* AppRun standard-notes.desktop .so*
  '';

  profile = ''
    export XDG_DATA_DIRS="${xdg_dirs}''${XDG_DATA_DIRS:+:"$XDG_DATA_DIRS"}"
  '';

  meta = with stdenv.lib; {
    description = "A simple and private notes app";
    longDescription = ''
      Standard Notes is a private notes app that features unmatched simplicity,
      end-to-end encryption, powerful extensions, and open-source applications.
    '';
    homepage = "https://standardnotes.org";
    license = licenses.agpl3;
    maintainers = with maintainers; [ mgregoire ];
    platforms = [ "i386-linux" "x86_64-linux" ];
  };
}

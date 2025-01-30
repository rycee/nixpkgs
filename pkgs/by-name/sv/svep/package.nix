{
  lib,
  fetchFromSourcehut,
  rustPlatform,
  nix-update-script,
}:

let
  version = "0.0.1-pre";
in
rustPlatform.buildRustPackage {
  pname = "svep";
  inherit version;

  src = fetchFromSourcehut {
    owner = "~rycee";
    repo = "svep";
    rev = "ca6670f1e40feba74096920feedf0b8090c4518d";
    hash = "sha256-W62yaxMaEhnh4R8Tf345A7NhL59DEMz+7zPI5L1YE0c=";
  };

  cargoHash = "sha256-YtgYop/z1QPhc0suXMGZE7CcOiiQy6SDBe1r3VUykXg=";

  outputs = [ "sexec" "out" ];

  preConfigure = ''
    export SVEP_SEXEC_PATH="$sexec/bin/sexec"
  '';

  preFixup = ''
    mkdir $sexec
    moveToOutput "bin/sexec" "$sexec"
  '';

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = with lib; {
    description = "Systemd unit switcher for Home Manager";
    mainProgram = "svep";
    homepage = "https://git.sr.ht/~rycee/svep";
    changelog = "https://git.sr.ht/~rycee/svep/refs/${version}";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ rycee ];
    platforms = platforms.linux;
  };
}

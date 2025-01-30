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
    rev = "f1090e02dc5b8f211d9350e74c104084ca45b364";
    hash = "sha256-wFnmPvDFPK3oW73a8FlDtkVDiENMjzy7JbqQaEDNLgM=";
  };

  cargoHash = "sha256-9VroEdM0cSMZqBOqQCIoE4udl78C1rUw5w2jRP7G08w=";

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

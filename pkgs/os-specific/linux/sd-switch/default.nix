{ lib, fetchFromSourcehut, rustPlatform, pkg-config, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "sd-switch";
  version = "0.3.0";

  src = fetchFromSourcehut {
    owner = "~rycee";
    repo = pname;
    rev = "e4e4a049e9216498100c9d1ab9bfb969161bfa18";
    hash = "sha256-nPiBFcKPF4WKJTjMO5fq3OZ6g3ngaQZ48LowUAMqtcM=";
  };

  cargoHash = "sha256-K5/ieMpo5qo5wsCyZPstAkRbZMlgFdSEP2KEXSgkiqQ=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ dbus ];

  meta = with lib; {
    description = "A systemd unit switcher for Home Manager";
    homepage = "https://git.sr.ht/~rycee/sd-switch/";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ rycee ];
    platforms = platforms.linux;
  };
}

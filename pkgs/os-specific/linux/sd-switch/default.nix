{ stdenv, fetchFromGitLab, rustPlatform, pkg-config, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "sd-switch";
  version = "0.2.1";

  src = fetchFromGitLab {
    owner = "rycee";
    repo = pname;
    rev = version;
    sha256 = "0sg1y8lb2pnll3408fbqp65acys31mrlzsqfrwm4nvbkayf0jcv3";
  };

  cargoSha256 = "06giznps9h40b7bd7xwi8ijg2sdrarz8948ab9amcl8filp8c3hz";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ dbus ];

  meta = with stdenv.lib; {
    description = "A systemd unit switcher for Home Manager";
    homepage = "https://gitlab.com/rycee/sd-switch";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ rycee ];
    platforms = platforms.linux;
  };
}

{ stdenv
, cmake
, fetchFromGitHub
, libudev
, libusb
, makeWrapper
, python3
, qtbase
, qttools
, wrapQtAppsHook
, zlib
}:

stdenv.mkDerivation rec {
  pname = "openambit";
  version = "0.5";

  src = fetchFromGitHub {
    owner = "openambitproject";
    repo = pname;
    rev = version;
    sha256 = "1074kvkamwnlkwdajsw1799wddcfkjh2ay6l842r0s4cvrxrai85";
  };

  outputs = [ "out" "dev" "lib" ];

  nativeBuildInputs = [ cmake makeWrapper qttools wrapQtAppsHook ];
  buildInputs = [ libusb libudev qtbase python3 ];

  cmakeFlags = [ "-DCMAKE_INSTALL_UDEVRULESDIR=${placeholder "out"}/lib/udev/rules.d" ];

  postInstall = ''
    install -m755 -D $src/tools/openambit2gpx.py $out/bin/openambit2gpx

    mv -v $out/lib/udev/rules.d/libambit.rules \
          $out/lib/udev/rules.d/20-libambit.rules
  '';

  meta = with stdenv.lib; {
    description = "Helps fetch data from Suunto Ambit GPS watches";
    homepage = "https://github.com/openambitproject/openambit/";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ rycee ];
    platforms = platforms.linux;
  };
}

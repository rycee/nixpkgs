{ stdenv, fetchurl }:

let

  version = "5.4";

in

fetchurl rec {
  name = "pecita-${version}";

  url = "http://pecita.eu/b/Pecita.otf";

  downloadToTemp = true;

  postFetch = ''
    mkdir -p $out/share/fonts/opentype
    mkdir -p $out/etc/fonts/conf.d
    cp -v $downloadedFile $out/share/fonts/opentype/Pecita.otf
    cp -v ${./fontconfig.conf} $out/etc/fonts/conf.d/45-pecita.conf
  '';

  recursiveHash = true;
  sha256 = "1kl061a6zzikskla206f8dls0jx0y9bdnamn843myrhgn7pc5i5q";

  meta = with stdenv.lib; {
    homepage = http://pecita.eu/police-en.php;
    description = "Handwritten font with connected glyphs";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = [maintainers.rycee];
  };
}

{ stdenv, fetchurl, makeWrapper, jdk }:

stdenv.mkDerivation rec {
  name = "lombok-1.18.12";

  src = fetchurl {
    url = "https://projectlombok.org/downloads/${name}.jar";
    sha256 = "01jl6i5wzjxyk36fcq6ji90x9h143gvnwhv86cbkqaxhxh41af29";
  };

  buildInputs = [ makeWrapper ];

  outputs = [ "out" "bin" ];

  buildCommand = ''
    mkdir -p $out/share/java
    cp $src $out/share/java/lombok.jar

    makeWrapper ${jdk}/bin/java $bin/bin/lombok \
      --add-flags "-cp ${jdk}/lib/openjdk/lib/tools.jar:$out/share/java/lombok.jar" \
      --add-flags lombok.launch.Main
  '';

  meta = {
    description = "A library that can write a lot of boilerplate for your Java project";
    platforms = stdenv.lib.platforms.all;
    license = stdenv.lib.licenses.mit;
    homepage = "https://projectlombok.org/";
    maintainers = [ stdenv.lib.maintainers.CrystalGamma ];
  };
}

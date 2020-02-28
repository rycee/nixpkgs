{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "jwt-cli";
  version = "3.0.1";

  src = fetchFromGitHub {
    owner = "mike-engel";
    repo = pname;
    rev = version;
    sha256 = "108pwk0h6zcbfmp0k8rhjxaa9yk8rhb78aaql22x48n11fnjl27i";
  };

  cargoSha256 = "1c4nsh6rrd3wg70shv27xdj5f31s5qgikrngi7wja8hssq50m9bq";

  meta = with stdenv.lib; {
    description = "Super fast CLI tool to decode and encode JWTs";
    homepage = "https://github.com/mike-engel/jwt-cli";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ rycee ];
    platforms = platforms.all;
  };
}

{ lib, fetchzip }:
let
  version = "2.1.2";
in fetchzip {
  name = "typicons-${version}";
  url = "https://github.com/stephenhutchings/typicons.font/archive/refs/tags/v${version}.zip";

  postFetch = ''
    mkdir -p $out/share/fonts/truetype
    unzip $downloadedFile
    cp ./typicons.font-${version}/src/font/typicons.ttf $out/share/fonts/truetype/
  '';

  sha256 = "IfWZOyej4em4GkEET2gTa+HeWguGvth2A4a4NqsJ+6U=";

  meta = with lib; {
    homepage = "https://www.s-ings.com/typeicons/";
    description = "A webfont of free-to-use vector icons";
    license = licenses.ofl;
    mantainers = [ "smkuehnhold" ]; 
  };
}

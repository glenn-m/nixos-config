{ stdenv, fetchFromGitHub, pkgconfig,
  libX11, libXtst, libXi, libXft, libXrandr
}:

stdenv.mkDerivation rec {
  name = "sdorfehs";
  version = "20191028";

  src = fetchFromGitHub {
    owner = "jcs";
    repo = "sdorfehs";
    rev = "v1.0";
    sha256 = "0ijk5qii7q4mg6vh8dlm738bay9giimhj2343x9x5bknplfv5ipp";
  };

  nativeBuildInputs = [ pkgconfig ];

  buildInputs = [ libX11 libXtst libXi libXft libXrandr ];

  makeFlags = [ "PREFIX=$(out)" ];

  meta = with stdenv.lib; {
    description = "sdorfehs is a tiling window manager descended from ratpoison";
    homepage = https://github.com/jcs/sdorfehs;
    license = licenses.gpl2;
    maintainers = with maintainers; [ glenn-m ];
    platforms = platforms.unix;
  };
}

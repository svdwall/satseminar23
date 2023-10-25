{ stdenv, cmake, fetchFromGitLab }:

stdenv.mkDerivation rec {
  pname = "thies-sat";
  version = "0.1";

  src = fetchFromGitLab {
    owner = "l1k3ab0t";
    repo = "cube-and-conquer";
    rev = "8693f01306dcf34b427bd55692f0be87eba1553e";
    sha256 = "gpLboX6wy9/RhX0KJcqDsXiWiSJpQ6X7/9KyFTN9L34=";
  };

  patches = [ ./read_dimacs.patch ];

  buildInputs = [
    cmake
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp cube $out/bin/thies
    runHook postInstall
  '';

  doCheck = false;
  checkPhase = ''
  '';
}


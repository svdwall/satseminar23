{ stdenv, cmake, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "benjamin-sat";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "bhennies";
    repo = "SAT_Solver";
    rev = "50fe96256d691e15875147a887a5821994cf279b";
    sha256 = "sha256-M8MZuO14XFm5XT8mF+yvccYh4D+Z9utbSrHuhDYOVvk=";
  };

  buildInputs = [
    cmake
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp SAT_Solver $out/bin/benjamin
    runHook postInstall
  '';

  doCheck = false;
  checkPhase = ''
  '';
}


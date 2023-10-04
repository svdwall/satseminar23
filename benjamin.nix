{ stdenv, cmake, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "benjamin-sat";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "bhennies";
    repo = "SAT_Solver";
    rev = "5e2c8a1777e7670fcde7d067be362ad80eb53459";
    sha256 = "qydwG9nlt3WZnI5uCbeJoFcyKGFCoZYiDq0VKVjmJwc=";
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


{ stdenv, cmake, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "natalia-sat";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "nagacek";
    repo = "SATsolver";
    rev = "0f7809563bde8d58f5bdfe3ea75a454d3fbec6b0";
    sha256 = "ycJs7SuId7sZelNByFxkf/voL42LAftebJ54HBGU52o=";
  };

  buildInputs = [
    cmake
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp SATsolver $out/bin/natalia
    runHook postInstall
  '';

  doCheck = false;
  checkPhase = ''
  '';
}


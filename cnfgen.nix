{ python3, fetchPypi, }:
ps: with ps; [
  (
    python3.pkgs.buildPythonPackage rec {
      pname = "CNFgen";
      version = "0.9.2";
      src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-usfr+hOurwH83GP4CeLAt6FaT7XKTugTy2aGi2zKlvk=";
      };
      doCheck = false;
      propagatedBuildInputs = [
        python3.pkgs.networkx
      ];
    }
  )
]

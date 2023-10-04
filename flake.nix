{
  description = "SatSolvers from Seminar 2023";

  inputs = {
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system: 
  let pkgs = import nixpkgs { inherit system; };
  in 
  with pkgs;
  {

    packages.natalia = callPackage ./natalia.nix { inherit fetchFromGitHub stdenv cmake; };
    packages.benjamin = callPackage ./benjamin.nix { inherit fetchFromGitHub cmake; stdenv = llvmPackages_16.stdenv; };
    packages.thies = callPackage ./thies.nix { inherit fetchFromGitLab cmake; stdenv = llvmPackages_16.stdenv; };
    packages.default = buildEnv {
      name = "sat-env";
      paths = [
        self.packages.${system}.natalia
        self.packages.${system}.benjamin
        self.packages.${system}.thies
      ];
    };

    
    devShells.default = mkShell rec {
      packages = with self.packages.${system};
      [
        natalia
        benjamin
        thies
      ];
    };
  });
}

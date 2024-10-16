{ pkgs ? import <nixpkgs> {} }:

pkgs.python3Packages.buildPythonApplication {
  pname = "myGame";
  version = "0.1.0";

  propagatedBuildInputs = with pkgs.python3Packages; [
    pygame
  ];

  src = ./.;
}

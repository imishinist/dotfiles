{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkShell{
  NIX_PATH = "nixpkgs=${builtins.toString pkgs.path}";
  nativeBuildInputs = [
    pkgs.nixpkgs-fmt
  ];
}

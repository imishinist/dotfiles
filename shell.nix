{ pkgs ? (
    let
      inherit (builtins) fetchTree fromJSON readFile;
    in
    import (fetchTree (fromJSON (readFile ./flake.lock)).nodes.nixpkgs.locked) {
      overlays = [ ];
    }
  )
}:

pkgs.mkShell
{
  NIX_PATH = "nixpkgs=${builtins.toString pkgs.path}";
  nativeBuildInputs = [
    pkgs.nixpkgs-fmt
    pkgs.home-manager
  ];
}

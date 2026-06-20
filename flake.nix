{
  description = "Modern Compiler Implementation in ML (Appel), but in OCaml.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        mipsCross = pkgs.pkgsCross.mips-linux-gnu.buildPackages;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            ocamlPackages.ocaml
            ocamlPackages.findlib
            dune_3

            ocamlPackages.utop
            ocamlPackages.ocaml-lsp
            ocamlPackages.ocamlformat

            ocamlPackages.menhir

            qemu-user

            mipsCross.binutils
          ];
        };
      }
    );
}

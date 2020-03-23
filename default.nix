{ pkgs ? import (import nix/fetch-nixpkgs.nix) {}
}:

with pkgs;

stdenv.mkDerivation {
  name = "LaTeX-env";
  buildInputs = [ (texlive.combine {
                    inherit (texlive)
                      scheme-small

                      # Add other LaTeX libraries (packages) here as needed, e.g:
                      acmart
                      cm-super
                      comment
                      environ
                      lazylist
                      ncctools
                      polytable
                      stmaryrd
                      totpages
                      trimspaces
                      xstring

                      # build tools
                      latexmk
                      ;
                  })
                  haskellPackages.lhs2tex

                ];
  src = ./.;
  buildPhase = "make";

  meta = with lib; {
    description = "Describe your document here";
    license = licenses.bsd3;
    platforms = platforms.linux;
  };
}

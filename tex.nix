with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    python3
    texlive.combined.scheme-full
  ];
}

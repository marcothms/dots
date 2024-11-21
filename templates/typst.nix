with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    (typst.overrideAttrs { version = "0.11.1"; })
  ];
}



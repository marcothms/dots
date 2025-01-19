with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    (typst.overrideAttrs { version = "0.12.0"; })
    tinymist
  ];
}



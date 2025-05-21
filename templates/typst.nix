# Before updating:
#
# 1. Make sure to be on unstable
# 2. nix-channel --update
# 
with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    (typst.overrideAttrs { version = "0.13.1"; })
    tinymist
  ];
}



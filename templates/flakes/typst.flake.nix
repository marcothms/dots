{
  description = "Nightly Typst with Typst LSP";

  inputs.typst-lsp.url = "github:nvarner/typst-lsp";
  inputs.typst.url = "github:typst/typst";
  inputs.utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = {
    nixpkgs,
    utils,
    typst,
    typst-lsp,
    ...
  }:
    utils.lib.eachDefaultSystem (system: let
      typst-overlay = _self: _super: {
        typst-lsp = typst-lsp.packages.${system}.default;
        typst = typst.packages.${system}.default.overrideAttrs (_old: {
          dontCheck = true;
        });
      };
      pkgs = nixpkgs.legacyPackages.${system}.appendOverlays [typst-overlay];
      typst-shell = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.typst-lsp
          pkgs.typst
        ];
      };
    in {
      devShells.default = typst-shell;
      overlays.default = typst-overlay;
      legacyPackages = pkgs;
    });
}

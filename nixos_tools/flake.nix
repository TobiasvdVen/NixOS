{
  description = "General utilties for managing the NixOS configuration and deploying systems.";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-26.05";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";
    tt-git.url = "github:TobiasvdVen/TvdvenTools";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, crane, tt-git }:
    let
      tt = tt-git.tt;
      systems = flake-utils.lib.eachDefaultSystem (system:
        let
          crane-args = {
            pname = "nt";
            version = "0.1.0";
            src = ./.;
          };

          tt-output = tt.mkRustOutput { inherit nixpkgs system rust-overlay crane crane-args; };
        in
        {
          devShells.default = tt-output.pkgs.mkShell {
            buildInputs = tt-output.buildInputs;
          };

          packages.default = tt-output.build;
        });
    in
      systems;
    }

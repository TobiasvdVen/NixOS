{
  description = "General utilties for managing the NixOS configuration and deploying systems.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";
    tt-git.url = "github:TobiasvdVen/TvdvenTools";
  };

  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
      flake-utils,
      crane,
      tt-git,
    }:
    let
      tt = tt-git.tt;
      systems = flake-utils.lib.eachDefaultSystem (
        system:
        let
          pre-pkgs = import nixpkgs { inherit system; };
          crane-args = {
            pname = "nt";
            version = "0.1.0";
            src = ./.;
            nativeBuildInputs = [
              pre-pkgs.nixos-install-tools
            ];
          };

          tt-output = tt.mkRustOutput {
            inherit
              nixpkgs
              system
              rust-overlay
              crane
              crane-args
              ;
          };

          pkgs = tt-output.pkgs;

          libInputs = [
            pkgs.wayland
            pkgs.libxkbcommon
            pkgs.libGL
            pkgs.libgcc
            pkgs.dbus
          ];

          libPath = pkgs.lib.makeLibraryPath libInputs;
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = tt-output.buildInputs ++ [
              tt-git.packages.${system}.default
              pkgs.wayland
              pkgs.package-version-server
              pkgs.dbus
            ];

            LD_LIBRARY_PATH = libPath;
          };

          packages.default = tt-output.build;
        }
      );
    in
    systems;
}

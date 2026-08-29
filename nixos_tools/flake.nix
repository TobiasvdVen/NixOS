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
          pkgs = tt.mkRustPkgs { inherit nixpkgs system rust-overlay; };

          libInputs = [
            pkgs.wayland
            pkgs.libxkbcommon
            pkgs.libGL
            pkgs.libgcc
            pkgs.dbus
          ];

          libPath = pkgs.lib.makeLibraryPath libInputs;

          nt-crane-args = {
            pname = "nt";
            version = "0.1.0";
            src = ./.;
            nativeBuildInputs = [
              pkgs.nixos-install-tools
            ];
            strictDeps = true;
            cargoExtraArgs = "-p nt";
          };

          nixos_tools-crane-args = {
            pname = "nixos_tools";
            version = "0.1.0";
            src = ./.;
            nativeBuildInputs = [
              pkgs.nixos-install-tools
              pkgs.makeWrapper
            ];
            strictDeps = true;
            cargoExtraArgs = "-p nixos_tools";
          };

          rust-toolchain = tt.mkRustToolchain { inherit pkgs; };
          default-crate-lib = crane.mkLib pkgs;
          crane-lib = default-crate-lib.overrideToolchain rust-toolchain;

          nt-crane-and-cargo = nt-crane-args // {
            cargoArtifacts = crane-lib.buildDepsOnly nt-crane-args;
          };

          nixos_tools-crane-and-cargo = nixos_tools-crane-args // {
            cargoArtifacts = crane-lib.buildDepsOnly nixos_tools-crane-args;
            postInstall = ''
              wrapProgram $out/bin/nixos_tools --prefix LD_LIBRARY_PATH : ${libPath}
            '';
            libs = libPath;
            buildInputs = libInputs;
          };

          nt-build = crane-lib.buildPackage nt-crane-and-cargo;
          nixos_tools-build = crane-lib.buildPackage nixos_tools-crane-and-cargo;
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = [
              tt-git.packages.${system}.default
              pkgs.wayland
              pkgs.package-version-server
              pkgs.dbus
              nt-build
              nixos_tools-build
            ];

            LD_LIBRARY_PATH = libPath;
          };

          packages.nt = nt-build;
          packages.nixos_tools = nixos_tools-build;
        }
      );
    in
    systems;
}

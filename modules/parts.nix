{inputs, ...}: {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
    inputs.home-manager.flakeModules.home-manager
    ./hosts/tobias-pc.nix
  ];

  config = {
    systems = ["x86_64-linux"];
  };
}

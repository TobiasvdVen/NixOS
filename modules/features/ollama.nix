{
  flake.nixosModules.features.ollama = {pkgs, ...}: {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      loadModels = ["qwen3:14b"];
    };
  };
}

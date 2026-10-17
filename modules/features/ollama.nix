{
  flake.nixosModules.ollama = {pkgs, ...}: {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      loadModels = ["qwen3-coder:30b"];
      syncModels = true;
    };
  };
}

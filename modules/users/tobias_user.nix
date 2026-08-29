{ ... }:
{
  users.users.tobias = {
    isNormalUser = true;
    description = "Tobias";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}

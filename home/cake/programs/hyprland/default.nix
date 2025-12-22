{
  config,
  lib,
  ...
}: let
  hyprEnabled = config.specialisation == "hyprland";
in {
  config = lib.mkIf hyprEnabled {
    home.file.".config/hypr" = {
      source = ./hypr;
      recursive = true;
    };
  };
}

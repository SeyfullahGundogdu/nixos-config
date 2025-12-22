{
  config,
  lib,
  ...
}: let
  hyprEnabled = config.specialisation == "hyprland";
in {
  config = lib.mkIf hyprEnabled {
    # our pywal config has a conflict with this,
    # doesn't matter though, executable is still available
    # services.mako.enable = true;
    home.file.".config/mako" = {
      source = ./mako;
      recursive = true;
    };
  };
}

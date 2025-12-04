{
  programs.pywal.enable = true;
  home.file = {
    # pywal template for mako compatible config
    ".config/wal/templates/colors-mako".source = ./colors-mako;
    # same config for hyprland and hyprlock
    ".config/wal/templates/colors-hyprland.conf".source = ./colors-hyprland.conf;
  };
}

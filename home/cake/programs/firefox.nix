{
  programs.firefox = {
    enable = true;
    profiles.seyfullah.settings = {
      # Always use XDG portals for stuff
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "widget.use-xdg-desktop-portal.mime-handler" = 1;
      "widget.use-xdg-desktop-portal.settings" = 1;
      "widget.use-xdg-desktop-portal.location" = 1;
      "widget.use-xdg-desktop-portal.open-uri" = 1;
    };
  };
}

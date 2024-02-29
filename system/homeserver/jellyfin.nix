{
  networking.firewall = {
    allowedTCPPorts = [8096];
    allowedUDPPorts = [
      8096
    ];
  };

  # Jellyfin
  virtualisation.oci-containers.containers."jellyfin" = {
    autoStart = true;
    image = "jellyfin/jellyfin";
    volumes = [
      #      "/media/Containers/Jellyfin/config:/config"
      #      "/media/Containers/Jellyfin/cache:/cache"
      "/media/log:/log"
      "/media/Movies:/movies"
      "/media/TV-Series:/tv"
    ];
    ports = ["8096:8096"];
    environment = {
      JELLYFIN_LOG_DIR = "/log";
    };
  };
}

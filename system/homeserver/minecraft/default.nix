{
  pkgs,
  ...
}:

{
  services.minecraft-server = {
    enable = true;
    openFirewall = true;
    eula = true;
    jvmOpts = "-Xmx2048M -Xms2048M";
    package = pkgs.minecraft-server;
  };
}

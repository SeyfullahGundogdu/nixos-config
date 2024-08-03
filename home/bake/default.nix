{username, ...}: {
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";
  imports = [
    #all the config files are defined in that directory
    ./programs
  ];
  fonts.fontconfig.enable = true;
  # home.packages = with pkgs; [
  # #managed by configuration.nix
  # ];

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    configFile = {
      # --enable-ozone
      # --enable-features=UseOzonePlatform
      "code-flags.conf".text = ''
        --ozone-platform=wayland
      '';
    };
  };
  qt.enable = true;
  qt.platformTheme.name = "kde";
  qt.style.name = "Breeze";

  home.sessionVariables = {
    EDITOR = "nano";
    BROWSER = "firefox";
    TERM = "alacritty";
    TERMINAL = "alacritty";
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_DISABLE_RDD_SANDBOX = 1;
    NIXOS_OZONE_WL = 1;
    MOZ_USE_XINPUT2 = "1"; # https://nixos.wiki/wiki/Firefox#Use_xinput2
  };
  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

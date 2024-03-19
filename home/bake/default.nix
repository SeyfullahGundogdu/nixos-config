{
  pkgs,
  username,
  ...
}: {
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";
  home.pointerCursor = {
    x11.enable = true; #might not be needed for wayland
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
  };
  imports = [
    ./programs.nix
    ./plasma.nix
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
  qt.platformTheme = "kde";
  qt.style.name = "Breeze";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/alacritty/alacritty.toml".source = ./config/alacritty/alacritty.toml;
    ".config/starship.toml".source = ./config/starship.toml;
    ".config/foot/foot.ini".source = ./config/foot/foot.ini;
    ".config/MangoHud/MangoHud.conf".source = ./config/MangoHud/MangoHud.conf;
  };

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

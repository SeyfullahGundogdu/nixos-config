# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  pkgs,
  username,
  hostname,
  theTimezone,
  theLocale,
  theLCVariables,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  services.power-profiles-daemon.enable = true;
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;

  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;

  # Enable networking
  networking.hostName = "${hostname}";
  networking.networkmanager.enable = true;
  # Set time zone
  time.timeZone = "${theTimezone}";
  # Select internationalisation properties
  i18n.defaultLocale = "${theLocale}";
  i18n.extraLocaleSettings = {
    LC_ALL = "${theLCVariables}";
    LC_ADDRESS = "${theLCVariables}";
    LC_IDENTIFICATION = "${theLCVariables}";
    LC_MEASUREMENT = "${theLCVariables}";
    LC_MONETARY = "${theLCVariables}";
    LC_NAME = "${theLCVariables}";
    LC_NUMERIC = "${theLCVariables}";
    LC_PAPER = "${theLCVariables}";
    LC_TELEPHONE = "${theLCVariables}";
    LC_TIME = "${theLCVariables}";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "trq";
  };

  services.xserver = {
    enable = true;
    xkb.layout = "tr";
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  # Enable sound.
  # https://nixos.wiki/wiki/PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.flatpak.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Define a user account.
  # Don't forget to set a different password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    initialPassword = "bake";
    extraGroups = ["wheel" "networkmanager" "libvirtd" "docker" "input"];
    shell = pkgs.zsh;
  };
  specialisation = {
    hyprland.configuration = {
      programs.hyprland.enable = true;
      environment.systemPackages = with pkgs; [
        #hyprland stuff
        pywal
        hyprlock
        swww
        mako
        pamixer
        pavucontrol
        playerctl
        brightnessctl
        grimblast
        waybar
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    #terminals
    alacritty
    foot

    #shells
    nushell
    zsh
    nh

    #CLI tools
    bat
    cava
    cmake
    eza
    htop
    killall
    libnotify
    nano
    ncdu
    neofetch
    neovim
    vim
    starship
    tree
    wev
    wget

    # programming
    libclang
    gcc
    libgcc
    llvmPackages_latest.libclang.lib
    rustc
    cargo
    jdk17
    nil
    postman
    lapce
    maven
    nodejs_18

    #Desktop apps
    bibata-cursors
    bitwarden
    dbeaver-bin
    postgresql
    deadbeef
    discord
    easyeffects
    gparted
    heroic
    libsForQt5.kate
    obs-studio
    qbittorrent
    qpwgraph
    #rustdesk
    signal-desktop
    spotify
    transmission_3
    tutanota-desktop
    vesktop
    vlc
    wireshark
    zed-editor

    #gaming
    goverlay
    lutris
    mangohud
    steam
  ];
  programs.mtr.enable = true;

  # fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    roboto-mono

    (nerdfonts.override {fonts = ["JetBrainsMono" "DroidSansMono"];})
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.smartd.enable = true;
  # Open ports in the firewall. jellyfin, steam etc.
  # kde connect: https://userbase.kde.org/KDEConnect#Troubleshooting
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
    allowedUDPPortRanges = [
      #kdeconnect
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedTCPPortRanges = [
      #kdeconnect
      {
        from = 1714;
        to = 1764;
      }
    ];
  };

  environment.shells = with pkgs; [zsh];
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  security.polkit.enable = true;
  system.stateVersion = "23.05";
}

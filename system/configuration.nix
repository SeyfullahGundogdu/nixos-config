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

  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };

  programs.spicetify.enable = true;
  programs.spicetify.theme = {
    name = "Comfy";
    src = "${pkgs.fetchFromGitHub {
      owner = "Comfy-Themes";
      repo = "Spicetify";
      rev = "2c22f3649a82e599be0e7eb506a0f83459caf9e8";
      hash = "sha256-KyhQuWotqcIHb9dU3PZnJe6QWN7LYbczR0W7IAxWGbg=";
    }}/Comfy";

    injectCss = true;
    injectThemeJs = true;
    replaceColors = true;
    overwriteAssets = true;
    sidebarConfig = true;
    homeConfig = true;
    additonalCss = "";
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  console.keyMap = "trq";

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;

  services.flatpak.enable = true;
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

  users.users."${username}" = {
    isNormalUser = true;
    initialPassword = "cake";
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
    vscode

    #Desktop apps
    bitwarden-desktop
    dbeaver-bin
    postgresql
    discord
    easyeffects
    qbittorrent
    qpwgraph
    signal-desktop
    slack
    transmission_4
    tutanota-desktop
    vesktop
    vlc
    zed-editor

    #gaming
    goverlay
    lutris
    mangohud

    # KDE
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    roboto-mono

    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  programs.mtr.enable = true;
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
    allowedTCPPorts = [3389];
    allowedUDPPorts = [3389];
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
  # remap copilot key to right click
  services.evremap = {
    enable = true;
    settings.device_name = "AT Translated Set 2 keyboard";
    settings.remap = [
      {
        input = [
          "KEY_LEFTMETA"
          "KEY_LEFTSHIFT"
          "KEY_F23"
        ];
        output = [
          "BTN_RIGHT"
        ];
      }
    ];
  };

  security.polkit.enable = true;
  system.stateVersion = "25.05";
}

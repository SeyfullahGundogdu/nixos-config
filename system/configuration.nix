{
  pkgs,
  lib,
  username,
  hostname,
  theTimezone,
  theLocale,
  theLCVariables,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix
  ];

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

  services = {
    power-profiles-daemon.enable = true;
    openssh.enable = true;
    smartd.enable = true;
    flatpak.enable = true;
    libinput.enable = true;

    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.autoNumlock = true;
      autoLogin.enable = true;
      autoLogin.user = "cake";
    };
    xserver.xkb = {
      layout = "tr";
      variant = "";
    };
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # remap copilot key to right click
    evremap = {
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
  };

  console.keyMap = "trq";

  security.rtkit.enable = true;
  security.polkit.enable = true;
  security = {
    pam = {
      services = {
        ${username} = {
          kwallet = {
            enable = true;
            package = pkgs.kdePackages.kwallet-pam;
          };
        };
      };
    };
  };
  programs = {
    firefox.enable = true;
    zsh.enable = true;
    dconf.enable = true;
    mtr.enable = true;

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 30d --keep 3";
      flake = "/home/${username}/nixos-config";
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    spicetify = {
      enable = true;
      theme = {
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
    };
  };

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
      #https://github.com/nix-community/nh
      environment.etc."specialisation".text = "hyprland";
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
    rustc
    llvmPackages_latest.libclang.lib
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

  # Enable the OpenSSH daemon.
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
  };
  #kde workspace overlay fix for too long env vars
  nixpkgs.overlays = lib.singleton (final: prev: {
    kdePackages =
      prev.kdePackages
      // {
        plasma-workspace = let
          # the package we want to override
          basePkg = prev.kdePackages.plasma-workspace;

          # a helper package that merges all the XDG_DATA_DIRS into a single directory
          xdgdataPkg = pkgs.stdenv.mkDerivation {
            name = "${basePkg.name}-xdgdata";
            buildInputs = [basePkg];
            dontUnpack = true;
            dontFixup = true;
            dontWrapQtApps = true;
            installPhase = ''
              mkdir -p $out/share
              ( IFS=:
                for DIR in $XDG_DATA_DIRS; do
                  if [[ -d "$DIR" ]]; then
                    cp -r $DIR/. $out/share/
                    chmod -R u+w $out/share
                  fi
                done
              )
            '';
          };

          # undo the XDG_DATA_DIRS injection that is usually done in the qt wrapper
          # script and instead inject the path of the above helper package
          derivedPkg = basePkg.overrideAttrs {
            preFixup = ''
              for index in "''${!qtWrapperArgs[@]}"; do
                if [[ ''${qtWrapperArgs[$((index+0))]} == "--prefix" ]] && [[ ''${qtWrapperArgs[$((index+1))]} == "XDG_DATA_DIRS" ]]; then
                  unset -v "qtWrapperArgs[$((index+0))]"
                  unset -v "qtWrapperArgs[$((index+1))]"
                  unset -v "qtWrapperArgs[$((index+2))]"
                  unset -v "qtWrapperArgs[$((index+3))]"
                fi
              done
              qtWrapperArgs=("''${qtWrapperArgs[@]}")
              qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "${xdgdataPkg}/share")
              qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "$out/share")
            '';
          };
        in
          derivedPkg;
      };
  });

  system.stateVersion = "25.05";
}

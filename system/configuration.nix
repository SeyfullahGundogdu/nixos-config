# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config,
  pkgs,
  inputs,
  username,
  hostname,
  theTimezone,
  theLocale,
  theLCVariables,
    
   ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.minegrub-theme = {
	enable = true;
	splash = "NixOS Rocks";
  };
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
   boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only
   boot.loader.grub.useOSProber = true;

  # Enable networking
  networking.hostName = "${hostname}"; # Define your hostname
  networking.networkmanager.enable = true;
  # Set your time zone
  time.timeZone = "${theTimezone}";
  # Select internationalisation properties
  i18n.defaultLocale = "${theLocale}";
  i18n.extraLocaleSettings = {
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
#    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
	enable = true;
	displayManager.sddm.enable = true;
	desktopManager.plasma5.enable = true;
  };

  

  # Configure keymap in X11
  services.xserver.layout = "tr";
  # services.xserver.xkbOptions = "";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    initialPassword = "bake";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  qt.enable = true;
  qt.platformTheme = "kde";
  qt.style = "adwaita-dark";
  #programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
	#cmake
	#java
	#obs
	vim
	wget
	killall
	#libclang
	#libgcc
	libsForQt5.kate
	nano
	#ncdu
	#obs-studio
	#heroic
	#bitwarden
	#dbeaver
	#deadbeef
	#discord
	#easyeffects
	#wireshark
	#tutanota-desktop
	#signal-desktop
	#rustdesk
	#qbittorrent
	#qpwgraph
	neovim
	#rustup
	#vscode
	#lapce
	#gparted
	#goverlay
	#tree
  ];
  programs.mtr.enable = true;
  programs.steam.enable = true;  
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  environment.shells = with pkgs; [zsh ];
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  security.polkit.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}


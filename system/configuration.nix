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
  ...
}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true;
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
  #boot.loader.grub.useOSProber = true;

  # Enable networking
  networking.hostName = "${hostname}";
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
  };

  services.xserver = {
	  enable = true;
	  displayManager.sddm.enable = true;
	  desktopManager.plasma5.enable = true;
    layout = "tr";
  };

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
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  programs.zsh.enable = true;
  # Define a user account.
  # Don't forget to set a different password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    initialPassword = "bake";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
    shell = pkgs.zsh;
  };
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
  # Open ports in the firewall. jellyfin, steam etc.
  # kde connect: https://userbase.kde.org/KDEConnect#Troubleshooting
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
    allowedUDPPortRanges = [
      #kdeconnect
      { from = 1714; to = 1764; } ];
    allowedTCPPortRanges = [
      #kdeconnect 
      { from = 1714; to = 1764; } ];
    
  };
  
  environment.shells = with pkgs; [zsh ];
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
  system.stateVersion = "23.05";

}


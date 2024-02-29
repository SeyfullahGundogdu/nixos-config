{
  config,
  pkgs,
  username,
  gitUsername,
  gitEmail,
  ...
}: {
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    alacritty
    bat
    #bitwarden
    #dbeaver
    #deadbeef
    #discord
    #easyeffects
    eza
    #heroic
    htop
    #lapce
    #lutris
    #mangohud
    neofetch
    #obs-studio
    #postgresql
    #postman
    #qbittorrent
    #qpwgraph
    #rustdesk
    #signal-desktop
    #spotify
    soundux
    #starship

    #steam
    #transmission
    #tutanota-desktop
    #vlc
    #vscode
    #wireshark
    (nerdfonts.override {fonts = ["JetBrainsMono" "DroidSansMono"];})

    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  programs.zsh = {
    enable = true;
    history = {
      size = 300000000;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      extended = true;
      ignoreDups = true;
      share = true;
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "regexp" "line"];
    };
    initExtra = ''
      bindkey ';5C' emacs-forward-word
      bindkey ';5D' emacs-backward-word
    '';

    shellAliases = {
      cat = "bat";
      ls = "eza -al --color=always --group-directories-first";
    };
  };

  programs = {
    alacritty.enable = true;
    starship.enable = true;
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
    };
    firefox = {
      enable = true;
    };
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
  qt.enable = true;
  qt.platformTheme = "kde";
  qt.style.name = "adwaita-dark";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/alacritty/alacritty.toml".source = ./config/alacritty/alacritty.toml;
    ".config/starship.toml".source = ./config/starship/starship.toml;
    ".config/foot/foot.ini".source = ./config/foot/foot.ini;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nano";
    BROWSER = "firefox";
    TERM = "alacritty";
    TERMINAL = "alacritty";
    TERMINAL_PROG = "alacritty";
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_DISABLE_RDD_SANDBOX = 1;
    MOZ_USE_XINPUT2 = "1"; # https://nixos.wiki/wiki/Firefox#Use_xinput2
  };
  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

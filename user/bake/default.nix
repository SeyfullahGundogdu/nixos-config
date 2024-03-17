{
  config,
  pkgs,
  username,
  gitUsername,
  gitEmail,
  hostname,
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
  imports = [./plasma.nix];
  fonts.fontconfig.enable = true;
  # home.packages = with pkgs; [
  # #managed by configuration.nix
  # ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
    alacritty.enable = true;
    starship.enable = true;
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    firefox = {
      enable = true;
      profiles.seyfullah.settings = {
        # Always use XDG portals for stuff
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "widget.use-xdg-desktop-portal.settings" = 1;
        "widget.use-xdg-desktop-portal.location" = 1;
        "widget.use-xdg-desktop-portal.open-uri" = 1;
      };
    };
    zsh = {
      enable = true;
      history = {
        size = 300000000;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
        extended = true;
        ignoreDups = true;
        share = false; #don't share between shell instances
      };

      historySubstringSearch = {
        enable = true;
        searchUpKey = "$terminfo[kcuu1]";
        searchDownKey = "$terminfo[kcud1]";
      };
      autocd = true;
      dotDir = ".config/zsh";
      autosuggestion.enable = true;
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
        yolo = "sudo nixos-rebuild boot --flake .#${hostname}";
      };
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      kamadorueda.alejandra
      rust-lang.rust-analyzer
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      yzhang.markdown-all-in-one
      ms-vscode.cpptools
      eamodio.gitlens
      jnoortheen.nix-ide
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
      mkhl.direnv
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      # "nix.serverPath" = "nixd";
      "editor.fontSize" = 15;
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "security.workspace.trust.banner" = "never";
    };
  };

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
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/alacritty/alacritty.toml".source = ./config/alacritty/alacritty.toml;
    ".config/starship.toml".source = ./config/starship/starship.toml;
    ".config/foot/foot.ini".source = ./config/foot/foot.ini;
    ".config/MangoHud/MangoHud.conf".source = ./config/MangoHud/MangoHud.conf;
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
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_DISABLE_RDD_SANDBOX = 1;
    NIXOS_OZONE_WL = 1;
    MOZ_USE_XINPUT2 = "1"; # https://nixos.wiki/wiki/Firefox#Use_xinput2
  };
  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

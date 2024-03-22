{
  config,
  pkgs,
  hostname,
  gitUsername,
  gitEmail,
  ...
}: {
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

    vscode = {
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
        "terminal.integrated.fontSize" = 15;
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
}

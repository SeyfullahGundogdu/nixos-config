{
  config,
  hostname,
  ...
}: {
  programs.zsh = {
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
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
    '';
    shellAliases = {
      cat = "bat";
      ls = "eza -al --color=always --group-directories-first";
      yolo = "sudo nixos-rebuild boot --flake .#${hostname}";
    };
  };
}

{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
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
      ms-python.python
    ];
    profiles.default.userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      # "nix.serverPath" = "nixd";
      "editor.fontSize" = 15;
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "security.workspace.trust.banner" = "never";
      "terminal.integrated.fontSize" = 15;
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
    };
  };
}

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
      username = {
        style_user = "green bold";
        style_root = "red bold";
        format = "[$user]($style) ";
        # disabled = false;
        # show_always = true;
      };
      character = {
        success_symbol = "[❯](bold red)[❯](bold green)[❯](bold blue)";
        error_symbol = "[✗](bold red)";
      };
      directory = {
        read_only = " ";
        truncation_length = 3;
        truncation_symbol = "…/";
        truncate_to_repo = true;
        style = "bold blue";
      };
      aws = {
        symbol = "  ";
      };
      conda = {
        symbol = " ";
      };
      dart = {
        symbol = " ";
      };
      elixir = {
        symbol = " ";
      };
      elm = {
        symbol = " ";
      };
      git_branch = {
        symbol = " ";
      };
      nim = {
        symbol = " ";
      };
      nix_shell = {
        symbol = " ";
      };
      package = {
        symbol = " ";
      };
      perl = {
        symbol = " ";
      };
      php = {
        symbol = " ";
      };
      python = {
        symbol = " ";
        # pyenv_version_name = true;
        format = "'via [\${symbol}python (\${version} )(\($virtualenv\) )]($style)'";
        style = "bold yellow";
        pyenv_prefix = "venv ";
        python_binary = ["./venv/bin/python" "python" "python3" "python2"];
        detect_extensions = ["py"];
        version_format = "v$${raw}";
      };
    };
  };
}

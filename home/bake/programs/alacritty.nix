{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        draw_bold_text_with_bright_colors = true;
        bright = {
          black = "#444b6a";
          blue = "#7da6ff";
          cyan = "#0db9d7";
          green = "#b9f27c";
          magenta = "#bb9af7";
          red = "#ff7a93";
          white = "#acb0d0";
          yellow = "#ff9e64";
        };
        normal = {
          black = "#32344a";
          blue = "#7aa2f7";
          cyan = "#449dab";
          green = "#9ece6a";
          magenta = "#ad8ee6";
          red = "#f7768e";
          white = "#787c99";
          yellow = "#e0af68";
        };
        primary = {
          background = "#11121D";
          foreground = "#a9b1d6";
        };
      };
      font = {
        size = 14;
        bold = {
          family = "RobotoMono";
          style = "Bold";
        };
        bold_italic = {
          family = "RobotoMono";
          style = "BoldItalic";
        };
        italic = {
          family = "RobotoMono";
          style = "MediumItalic";
        };
        normal = {
          family = "RobotoMono";
          style = "Medium";
        };
      };
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      selection = {
        save_to_clipboard = false;
      };
      window = {
        opacity = 1;
        class = {
          general = "Alacritty";
          instance = "Alacritty";
        };
        dimensions = {
          columns = 100;
          lines = 24;
        };
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}

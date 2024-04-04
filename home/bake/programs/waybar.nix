{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-left = 5;
        margin-right = 5;
        margin-top = 5;
        spacing = 5;
        height = 32;
        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          # "cpu"
          # "memory"
          # "temperature"
          "backlight"
          "keyboard-state"
          "hyprland/language"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          # format= "{name}= {icon}";
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "default" = " ";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        "custom/launcher" = {
          "format" = "❄️ ";
          "on-click" = "exec /etc/profiles/per-user/joe/bin/fuzzel";
          "on-click-middle" = "exec /etc/profiles/per-user/joe/bin/fuzzel";
          "on-click-right" = "exec /etc/profiles/per-user/joe/bin/fuzzel";
          "tooltip" = false;
        };

        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = " ";
            unlocked = " ";
          };
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        tray = {
          # "icon-size"= 21;
          spacing = 10;
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%b %d %Y}";
        };
        temperature = {
          # "thermal-zone"= 2;
          # "hwmon-path"= "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format = "{temperatureC}°C";
        };

        backlight = {
          "device" = "intel_backlight";
          "rotate" = 0;
          "format" = "{icon}";
          "format-icons" = [" " " " " " " " " " " " " " " " " "];
          "on-scroll-up" = "brightnessctl --device intel_backlight set 5%+";
          "on-scroll-down" = "brightnessctl --device intel_backlight --min-value=1000 set 5%-";
        };

        battery = {
          states = {
            # "good"= 95;
            warning = 30;
            critical = 15;
          };
          format = "{time} {icon}";
          format-charging = "{capacity}%";
          format-plugged = "{capacity}%";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        network = {
          # "interface"= "wlp2*"; # (Optional) To force the use of this interface
          format-wifi = " ";
          "format-ethernet" = "󰈀 ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-disconnected = "⚠ ";
          # format-alt = "{ipaddr}";
        };

        pulseaudio = {
          format = "{icon}";
          format-muted = "󰖁 ";
          format-icons = {
            default = [" " " " "󰕾 "];
          };
          on-click = "pamixer -t";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          on-click-right = "exec pavucontrol";
          tooltip-format = "{volume}%";
        };

        "hyprland/window" = {
          max-length = 54;
        };
        "hyprland/language" = {
          format = "{short}";
        };
      };
    };

    style = ''
      @import "colors-waybar.css";
         * {
           border: none;
           font-family: JetBrainsMono Nerd Font;
           font-size: 16px;
         }

         window#waybar {
           color: @foreground;
           background: @background;
           transition-property: background-color;
           transition-duration: .5s;
           border-radius: 1em;
        }

        .modules-right {
           color: @foreground;
           padding-left: 0.2em;
           padding-right: 1em;
        }

        .modules-left {
           color: @foreground;
           padding-left: 0.6em;
           padding-right: 0.6em;
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #temperature,
        #network,
        #pulseaudio,
        #custom-media,
        #tray,
        #mode,
        #custom-power,
        #custom-menu,
        #idle_inhibitor {

           color: @foreground;
        }

        #clock {
          font-weight: bold;
        }

        #workspaces button {

           color: @foreground;
          font-size: large;
          border-radius:0.8em;
        }

        #workspaces button.active {
          background: @foreground;
          color: @color0;
          border-radius: 0.5em;
          padding-left: 0.5em;
          padding-right: 0.5em;
        }
    '';
  };
}

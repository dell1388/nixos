{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    style = ''
      * {
        font-family: JetBrains Mono;
        font-size: 14px;
        color: @base0B; /* Neon green HUD */
        background: @base00; /* Dark gray */
      }
      #workspaces button {
        color: @base0B;
        background: @base01;
        border: none;
        padding: 0px;
      }
      #workspaces button.active {
        color: @base08; /* Red for active */
        border-bottom: 2px solid @base0B; /* Neon green underline */
      }
      #cpu, #memory, #network {

        padding: 3px 8px;
        font-size: 12px;
        font-weight: bold;
      }
      #cpu.critical, #memory.critical {
        color: @base08; /* Red text above 80% */
      }
      #network {
        color: @base0B; /* Green text when connected */
      }
      #network.disconnected {
        color: @base08; /* Red text when disconnected */
      }
      #clock {
        color: @base0B; /* Yellow mission clock */
        font-weight: bold;

        padding: 3px 8px;
      }
    '';
    settings = [
      {
        height = 40;
        spacing = 10;
        tray = {
          spacing = 20;
          show-passive-items = true;
          background = "@base0B";
        };
        layer = "top";
        position = "bottom";
        modules-center = ["hyprland/window"];
        modules-right = ["tray" "pulseaudio" "network" "cpu" "memory" "temperature" "disk" "clock" "custom/mt"];
        modules-left = ["hyprland/workspaces"];
        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["" ""];
        };

        clock = {
          interval = 1;
          format = "{:%H:%M:%S   %Y-%m-%d}";
        };
        "clock#c2".format = "{:%m-%d}";
        "custom/mt" = {
          interval = 1;
          exec = "chron";
          format = "{}";
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory.format = "{}% ";
        disk.format = "{percentage_used}% ⬤";
        network = {
          interval = 1;
          tooltip-format = "{ifname}: {ipaddr}/{cidr} |  ^ {bandwidthUpBits}, v {bandwidthDownBits} | {essid}";
          format-disconnected = "⚠";
          format-ethernet = "{signalStrength} ";
          format-wifi = "{signalStrength} ";
          format-linked = "{ifname} (No IP)";
          on-click = "nm-connection-editor";
        };
        pulseaudio = {
          format = "{volume}% {icon}     {format_source}";
          format-bluetooth = "{volume}% {icon}  {format_source}";
          format-bluetooth-muted = " {icon}  {format_source}";
          format-icons = {
            car = "";
            default = ["" "" ""];
            handsfree = "";
            headphones = "";
            headset = "";
            phone = "";
            portable = "";
          };
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          on-click = "pavucontrol";
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };
      }
    ];
  };
}

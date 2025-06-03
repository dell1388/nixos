{
  config,
  pkgs,
  ...
}: {
programs.waybar = {
      enable = true;
style = ''
   #clock, #cpu{
    border: 1px solid #d5c4a1;
    border-radius: 1px;
    padding: 2px 4px;
    margin: 2px;
  }
'';
    settings = [

        {
          height = 40;
          spacing = 10;
          tray = {
            spacing = 20;
            show-passive-items = true;
          };
          layer = "top";
          position = "bottom";
          modules-center = ["hyprland/window"];
          modules-right = ["tray" "pulseaudio" "network" "cpu" "memory" "temperature" "disk" "clock#c2" "clock" "custom/mt"];
          modules-left = ["hyprland/workspaces"];
          backlight = {
            format = "{percent}% {icon}";
            format-icons = ["" ""];
          };

          clock = {
            interval = 1;
            format = "{:%H:%M:%S}";
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
            format = "{volume}% {icon}   {format_source}";
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

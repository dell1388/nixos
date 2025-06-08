{
  config,
  pkgs,
  ...
}: {
programs.waybar = {
      enable = true;
style = ''
* {
    font-family: "JetBrainsMono Nerd Font Mono";
    font-size: 10pt;

}
window#waybar, tooltip {
    background: alpha(@base00, 1.000000);
    color: @base05;
}

tooltip {
    border-color: @base0C;
}
#wireplumber,
#pulseaudio,
#sndio {
    padding: 0 5px;
}
#wireplumber.muted,
#pulseaudio.muted,
#sndio.muted {
    padding: 0 5px;
}
#upower,
#battery {
    padding: 0 5px;
}
#upower.charging,
#battery.Charging {
    padding: 0 5px;
}
#network {
    padding: 0 5px;
}
#network.disconnected {
    padding: 0 5px;
}
#user {
    padding: 0 5px;
}
#clock {
    padding: 0 5px;
}
#backlight {
    padding: 0 5px;
}
#cpu {
    padding: 0 5px;
}
#disk {
    padding: 0 5px;
}
#idle_inhibitor {
    padding: 0 5px;
}
#temperature {
    padding: 0 5px;
}
#mpd {
    padding: 0 5px;
}
#language {
    padding: 0 5px;
}
#keyboard-state {
    padding: 0 5px;
}
#memory {
    padding: 0 5px;
}
#window {
    padding: 0 5px;
}

.modules-left  {
padding: 0px 11px 0px 11px; 
background-color:@base00;
 	min-width: 1px;
	color: @base07;
}
.modules-left #workspaces button.focused,
.modules-left #workspaces button.active {
    border-bottom: 3px solid @base04;
    padding: 0px 11px 0px 11px;
    background-color:@base02;
    color: @base07;
}
.modules-center #workspaces button {
    border-bottom: 3px solid transparent;
}
.modules-center #workspaces button.focused,
.modules-center #workspaces button.active {
    border-bottom: 3px solid @base05;
}
.modules-right{
}
.modules-right #workspaces button.focused,
.modules-right #workspaces button.active {
    
}

    #workspaces{
    }
   #clock, #network, #memory, #pulseaudio, #disk, #cpu, #tray{
    color: @base00;
    border-radius: 2px;
    padding: 5px 4px;
    margin: 2px;
    background-color:@base02;
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

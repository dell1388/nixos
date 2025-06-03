{
  config,
  pkgs,
  ...
}: {
imports=[./waybar.nix];
  home.stateVersion = "23.11";
  stylix.targets = {
    fish.enable = false;
    kde.enable = false;
  };
  wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hyprland.conf;
  wayland.windowManager.hyprland.enable = true;
  programs = {
  git = {
      enable = true;
      userEmail = "benpewittlewis@gmail.com";
      userName = "dell1388";
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      location = "center";
      terminal = "kitty";
      plugins = with pkgs; [rofi-emoji-wayland (rofi-calc.override {rofi-unwrapped = pkgs.rofi-wayland-unwrapped;})];
      extraConfig = {
        kb-primary-paste = "Control+V,Shift+Insert";
        drun-display-format = "{icon} {name}";
        show-icons = true;
        hide-scrollbar = true;
        display-drun = " 󰀘 =>  ";
        display-calc = " ⅀ =>  ";
      };
    };
#     waybar = {
#       enable = true;
# style = ''
#    #clock, #cpu{
#     border: 1px solid #d5c4a1;
#     border-radius: 1px;
#     padding: 2px 4px;
#     margin: 2px;
#   }
# '';
#     settings = [
#
#         {
#           height = 40;
#           spacing = 10;
#           tray = {
#             spacing = 20;
#             show-passive-items = true;
#           };
#           layer = "top";
#           position = "bottom";
#           modules-center = ["hyprland/window"];
#           modules-right = ["tray" "pulseaudio" "network" "cpu" "memory" "temperature" "disk" "clock#c2" "clock" "custom/mt"];
#           modules-left = ["hyprland/workspaces"];
#           backlight = {
#             format = "{percent}% {icon}";
#             format-icons = ["" ""];
#           };
#
#           clock = {
#             interval = 1;
#             format = "{:%H:%M:%S}";
#           };
#           "clock#c2".format = "{:%m-%d}";
#           "custom/mt" = {
#             interval = 1;
#             exec = "chron";
#             format = "{}";
#           };
#
#           cpu = {
#             format = "{usage}% ";
#             tooltip = false;
#           };
#           memory.format = "{}% ";
#           disk.format = "{percentage_used}% ⬤";
#           network = {
#             interval = 1;
#             tooltip-format = "{ifname}: {ipaddr}/{cidr} |  ^ {bandwidthUpBits}, v {bandwidthDownBits} | {essid}";
#             format-disconnected = "⚠";
#             format-ethernet = "{signalStrength} ";
#             format-wifi = "{signalStrength} ";
#             format-linked = "{ifname} (No IP)";
#             on-click = "nm-connection-editor";
#           };
#           pulseaudio = {
#             format = "{volume}% {icon}   {format_source}";
#             format-bluetooth = "{volume}% {icon}  {format_source}";
#             format-bluetooth-muted = " {icon}  {format_source}";
#             format-icons = {
#               car = "";
#               default = ["" "" ""];
#               handsfree = "";
#               headphones = "";
#               headset = "";
#               phone = "";
#               portable = "";
#             };
#             format-muted = " {format_source}";
#             format-source = "{volume}% ";
#             format-source-muted = "";
#             on-click = "pavucontrol";
#           };
#           temperature = {
#             critical-threshold = 80;
#             format = "{temperatureC}°C {icon}";
#             format-icons = ["" "" ""];
#           };
#
#         }
#       ];
#     };
    kitty = {
      enable = true;
      settings = {
        enable_audio_bell = true;
        confirm_os_window_close = "0";
      };
      extraConfig = ''
        map ctrl+c copy_or_interrupt
        map kitty_mod+w no_op
        map shift+cmd+d no_op
        map ctrl+d no_op
      '';
    };

    foot = {
      enable = true;
      settings = {
        main.term = "xterm-256color";
        mouse.hide-when-typing = "yes";
      };
    };
  };
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform "
      "--ozone-platform=wayland"
      "--password-store=basic"
    ];
  };
  services = {
    dunst = {
      enable = true;
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = "16x16";
      };
      settings = {
        global = {
          monitor = 0;
          geometry = "600x50-5+25";
          shrink = "yes";
          padding = 16;
          horizontal_padding = 16;
          line_height = 4;
          format = "<b>%s</b>\\n%b";
          corner_radius = 20;
        };
      };
    };
    hyprpaper = {
      enable = true;
      settings = {
        wallpaper = [",${config.stylix.image}"];
      };
    };
  };
}

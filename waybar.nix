{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true; # Ensure Waybar starts correctly
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = ["memory" "cpu"];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["network" "clock"];
        cpu = {
          format = "ЦПУ: {usage}%";
          states = {
            critical = 80;
          };
        };
        memory = {
          format = "КАМ: {percentage}%";
          states = {
            critical = 80;
          };
        };
        network = {
          "format-wifi" = "ТДЛ: ОНЛАЙН";
          "format-ethernet" = "ТДЛ: ОНЛАЙН";
          "format-disconnected" = "ТДЛ: ОФФЛАЙН";
        };
        clock = {
          format = "{:%H:%M:%S}";
          interval = 1;
        };
      };
    };
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
  };
}

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
      position = "bottom"; # Force bottom position
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "cpu" "memory" "network" ];
      modules-right = [ "clock" ];
      cpu = { format = "CPU: {usage}%"; };
      memory = { format = "RAM: {used}GB"; };
      network = { format = "{ifname}: {bandwidthDownBits}"; };
      clock = { format = "{:%H:%M:%S}"; };
    };
  };
  style = ''
    * {
      font-family: Exo 2;
      color: #00ff9f; /* Neon green HUD */
      background: #1a1a1a; /* Dark gray */
    }
    #cpu, #memory, #network {
      background: #2e2e2e;
    }
    #workspaces button.active {
      background: #ff4d4d; /* Red */
    }
    #clock {
      color: #ffcc00; /* Yellow */
    }
  '';
 };}

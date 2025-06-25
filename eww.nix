{
  config,
  pkgs,
  ...
}: {
  # Enable EWW
  programs.eww = {
    enable = true;
    package = pkgs.eww;
  };

  home.file.".config/fighter_hud.html".source = ./su30hud.html;
  home.file.".config/eww/get-system-data.sh".source = pkgs.writeShellScriptBin "get-system-data.sh" ''
    #!/usr/bin/env bash
    cat << EOF
    {
      "cpu_load": $(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1 | cut -d'u' -f1 | tr -d ' '),
      "mem_usage": $(free | grep Mem | awk '{printf("%.0f", $3/$2 * 100.0)}'),
      "cpu_temp": $(sensors | grep 'Core 0' | awk '{print $3}' | cut -d'+' -f2 | cut -d'°' -f1 | head -1),
      "net_down": $(cat /sys/class/net/$(ip route | grep '^default' | awk '{print $5}' | head -1)/statistics/rx_bytes),
      "net_up": $(cat /sys/class/net/$(ip route | grep '^default' | awk '{print $5}' | head -1)/statistics/tx_bytes),
      "disk_usage": $(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1),
      "proc_count": $(ps aux | wc -l),
      "load_avg": $(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | cut -d',' -f1),
      "uptime": "$(uptime -p | sed 's/up //')",
      "time": "$(date '+%H:%M:%S')"
    }
    EOF
  '';
  home.file.".config/eww/launch-hud.sh" = {
    text = ''
        #!/usr/bin/env bash
      python3 -m http.server 8081 --directory $HOME/.config/eww/ --bind localhost &

        ${pkgs.chromium}/bin/chromium --app="file://$HOME/.config/eww/fighter_hud.html" &
    '';
    executable = true;
  };
  home.file.".config/eww/eww.yuck".text = ''
    # (defwindow hud-launcher
    #      :monitor 0
    #      :geometry (geometry :x "0" :y "0" :width "1" :height "1")
    #      :stacking "fg"
    #      :windowtype "desktop"
    #      :wm-ignore true
    #      (box
    #        (button :onclick "~/.config/eww/launch-hud.sh"
    #                :visible false
    #                "")))
  '';

  home.file.".config/eww/eww.scss".text = ''
    * {
        all: unset;
      }
  '';
}

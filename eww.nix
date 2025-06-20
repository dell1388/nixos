{ config, pkgs, ... }:

{
  # Enable EWW
  programs.eww = {
    enable = true;
    package = pkgs.eww;
  };

home.file.".config/eww/eww.yuck".text = ''
    (defwidget fpv-widget []
      (box :class "fpv" ""))

    (defwidget heading []
      (box :class "section"
        (label :class "label" "HEADING")
        (box :class "circle" "273°")))

    (defwidget system-readouts []
      (box :class "readouts-container"
        (box :class "section"
          (label :class "label" "SYSTEM")
          (label :class "value" "CPU 23%")
          (label :class "value" "MEM 51%")
          (label :class "value" "TMP 42°C"))
        (box :class "section"
          (label :class "label" "NETWORK")
          (label :class "value" "NET ↓54.2")
          (label :class "value" "NET ↑12.8")
          (label :class "value" "DSK 46%"))
        (box :class "section"
          (label :class "label" "RANGE")
          (label :class "value" "2.4KM"))
        (box :class "section"
          (label :class "label" "SYSTEM LOAD")
          (label :class "value" "PROC 247")
          (label :class "value" "LOAD 1.23"))
        (box :class "section"
          (label :class "label" "STATUS")
          (label :class "value" "SYS STATUS: OPERATIONAL"))
        (box :class "section"
          (label :class "label" "MODE")
          (label :class "value" "NAV"))
        (box :class "section"
          (label :class "label" "TIME")
          (label :class "value" "14:27:33")
          (label :class "value" "UPTIME 2d 4h"))))

    (defwindow su30-hud
      :monitor 0
      :stacking "fg"
      :windowtype "normal"
      :wm-ignore false
      (box :class "hud-container"
        (fpv-widget)
        (heading)
        (system-readouts)))
  '';

  home.file.".config/eww/eww.scss".text = ''
    .hud-container {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 20px;
      padding: 20px;
      background: rgba(0, 255, 0, 0.1);
      border: 2px solid #0f0;
      border-radius: 10px;
      font-family: 'Courier New', monospace;
      color: #0f0;
    }
    .readouts-container {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }
    .section {
      display: flex;
      flex-direction: column;
      align-items: center;
      font-size: 14px;
    }
    .label {
      font-weight: bold;
      margin-bottom: 5px;
    }
    .value {
      font-size: 16px;
    }
    .circle {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      border: 2px solid #0f0;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-top: 5px;
    }
    .fpv {
      width: 100px;
      height: 100px;
      background: #000;
      border: 1px solid #0f0;
    }
  '';

  home.packages = with pkgs; [
    coreutils
    procps
  ];
    }

{ config, pkgs, ... }:

{
  # Enable EWW
  programs.eww = {
    enable = true;
    package = pkgs.eww;
  };

  # EWW configuration
  home.file.".config/eww/eww.yuck".text = ''
  '';

  home.file.".config/eww/eww.scss".text = ''
    /* Add your EWW styles here */
  '';

}

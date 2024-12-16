{pkgs, ...}:
{
home.stateVersion = "23.11";
programs.chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [
        "--enable-features=UseOzonePlatform "
        "--ozone-platform=wayland"
        "--password-store=basic"
      ];
    };
}

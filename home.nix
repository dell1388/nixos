{pkgs, ...}:
{
home.stateVersion = "24.05";
chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [
        "--enable-features=UseOzonePlatform "
        "--ozone-platform=wayland"
        "--password-store=basic"
      ];
      extensions = [
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
        "nngceckbapebfimnlniiiahkandclblb" # bitwarden
        "hfjbmagddngcpeloejdejnfgbamkjaeg" # vimium-c
        "pnlccmojcmeohlpggmfnbbiapkmbliob" # roboform
        "cndibmoanboadcifjkjbdpjgfedanolh" # canvas
      ];
    };
}

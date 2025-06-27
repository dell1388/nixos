{
  config,
  pkgs,
  ...
}: {
  # Enable EWW
  programs.fish = {
    enable = true;
    shellAbbrs = {
    sgcpc = "cd ~/Documents/SGC/ && quickemu -vm windows-10.conf";
    };
    interactiveShellInit = ''
    if status is-interactive
        fastfetch
        set fish_greeting ""
    end
    '';
    functions = {
    fish_command_not_found = ''
    echo skill issue: $argv[1]
    '';
    };
  };

  }

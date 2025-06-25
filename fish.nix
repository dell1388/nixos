{
  config,
  pkgs,
  ...
}: {
  # Enable EWW
  programs.fish = {
    enable = true;
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

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  system,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./nixvim.nix
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    image = ./CTR_6868.jpg;

    polarity = "dark";

    opacity = {
      terminal = 0.7;
      popups = 0.9;
    };
    cursor = {
      name = "graphite-light";
      package = pkgs.graphite-cursors;
      size = 32;
    };

    fonts = {
      sizes = {
        terminal = 13;
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "NotoSans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "NotoSerif";
      };
    };

    targets = {
      fish.enable = false;
      nixvim.enable = false;
    };
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Volibear"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  programs.hyprland.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];
  };
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
  };
  services.openssh = {
    enable = true;
    ports = [22];
    # settings = {
    #   PasswordAuthentication = false;
    #   AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
    #   UseDns = true;
    #   X11Forwarding = false;
    #   PermitRootLogin = "yes"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    # };
  };
  services.fail2ban.enable = true;
  # services.udev.extraRules = ''
  #   KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  # '';
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "92-viia.rules";
      text = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      '';

      destination = "/etc/udev/rules.d/92-viia.rules";
    })
  ];
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.ratbagd = {
    enable = true;
  };
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dell = {
    isNormalUser = true;
    description = "dell";
    extraGroups = ["networkmanager" "libvirtd" "wheel"];
    shell = pkgs.fish;
  };
  home-manager = {
    users.dell = import ./home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  nix.settings.experimental-features = ["flakes" "nix-command"];

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [glib gtk3];
    };
    firefox.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    fish.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      flake = "/home/dell/.config/nixos";
    };
  };

  nixpkgs.pkgs = let
    overlays = [
      (final: _prev: {
        stable = import inputs.stable {
          system = final.system;
          config.allowUnfree = true;
        };
      })
    ];

    pkgs = import inputs.unstable {
      inherit overlays system;
      config.allowUnfree = true;
    };
  in
    pkgs;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    spotify
    libnotify
    libreoffice
    gimp
    vlc
    fastfetch
    wdisplays
    pavucontrol
    pulsemixer
    pasystray
    btop
    hyprpicker
    hyprpaper
    wl-clipboard
    xwaylandvideobridge
    killall
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        tabulate
      ]))
    gcc
    quickemu
    typst
    nvd
    nix-output-monitor
    networkmanagerapplet
    speedtest-cli
    git
    doublecmd
    curl
    cliphist
    hyprshot
    swappy
    tinymist
    vesktop
    swaylock
    wine
    lutris
    alejandra
    ruff
    r2modman
    piper
    libratbag
    via
    solaar
    jdk
    vscode
    gradle
    tmate
    octave
    anydesk
    gtk3
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

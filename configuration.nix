{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale / timezone
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # X11 + LightDM + bspwm
  services.xserver = {
    enable = true;

    displayManager.lightdm.enable = true;

    windowManager.bspwm.enable = true;
  };

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Graphics
  hardware.graphics.enable = true;

  # User
  users.users.mike = {
    isNormalUser = true;
    description = "Mike";

    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
  };

  # Passwordless sudo for wheel
  security.sudo.wheelNeedsPassword = false;

  # Basic software
  environment.systemPackages = with pkgs; [
    git
    vim
    nano
    wget
    curl

    # Desktop
    alacritty
    rofi
    dunst
    picom
    thunar
  ];

  # This is a fresh NixOS 26.05 installation
  system.stateVersion = "26.05";
}

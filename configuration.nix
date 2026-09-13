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

  # Time / locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # X11 + LightDM + Qtile
  services.xserver = {
    enable = true;

    displayManager.lightdm.enable = true;

    windowManager.qtile = {
      enable = true;
    };
  };

  # PipeWire
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

  # A few basic utilities
  environment.systemPackages = with pkgs; [
    git
    vim
    nano
    wget
    curl
  ];

  # NixOS release version
  system.stateVersion = "26.05";
}

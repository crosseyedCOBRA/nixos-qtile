{ config, pkgs, ... }:

let
  qtileNoTests = pkgs.qtile.overrideAttrs (oldAttrs: {
    doCheck = false;
  });
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot
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
      package = qtileNoTests;
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

  # Passwordless sudo
  security.sudo.wheelNeedsPassword = false;

  # Basic utilities
  environment.systemPackages = with pkgs; [
    git
    vim
    nano
    wget
    curl
  ];

  system.stateVersion = "26.05";
}

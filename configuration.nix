{ config, pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable LightDM display manager
  services.xserver.displayManager.lightdm.enable = true;

  # Enable Qtile Window Manager (X11)
  services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages = python3Packages: with python3Packages; [
      qtile-extras
    ];
  };

  # Disable PulseAudio (required for PipeWire to take over)
  hardware.pulseaudio.enable = false;
  
  # Enable PipeWire Sound Service
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable Flatpak support
  services.flatpak.enable = true;

  # Desktop Portals (Required for Flatpak features)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # Essential utilities and tools
  environment.systemPackages = with pkgs; [
    alacritty             # Terminal emulator
    rofi                  # Menu/Launcher
    picom                 # Compositor
    feh                   # Wallpaper tool option 1
    xwallpaper            # Wallpaper tool option 2
    xlibre                # Pre-installing xlibre headers/tools
    git
    vim
    pavucontrol           # GUI volume control for PipeWire/Pulse
  ];

  # System fonts
  fonts.packages = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-emoji
  ];
}

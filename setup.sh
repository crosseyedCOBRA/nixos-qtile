#!/bin/bash

# Define paths
QTILE_DIR="$HOME/.config/qtile"
NIX_DIR="/etc/nixos"

echo "Creating Qtile configuration directory..."
mkdir -p "$QTILE_DIR"

echo "Copying config.py and autostart.sh to $QTILE_DIR..."
cp config.py "$QTILE_DIR/config.py"
cp autostart.sh "$QTILE_DIR/autostart.sh"

echo "Making autostart.sh executable..."
chmod +x "$QTILE_DIR/autostart.sh"

echo "----------------------------------------"
echo "Qtile configurations successfully deployed to $QTILE_DIR"
echo "----------------------------------------"
echo ""
echo "To copy your configuration.nix, administrative privileges are required."
read -p "Would you like to backup and replace /etc/nixos/configuration.nix now? (y/N): " choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
    if [ -f "$NIX_DIR/configuration.nix" ]; then
        echo "Backing up existing configuration.nix to configuration.nix.bak..."
        sudo cp "$NIX_DIR/configuration.nix" "$NIX_DIR/configuration.nix.bak"
    fi
    echo "Copying new configuration.nix to $NIX_DIR..."
    sudo cp configuration.nix "$NIX_DIR/configuration.nix"
    
    echo ""
    read -p "Would you like to run 'sudo nixos-rebuild switch' now? (y/N): " rebuild_choice
    if [[ "$rebuild_choice" =~ ^[Yy]$ ]]; then
        sudo nixos-rebuild switch
    fi
else
    echo "Skipped configuration.nix installation. You can manually copy it later:"
    echo "sudo cp configuration.nix /etc/nixos/configuration.nix"
fi

echo ""
echo "Setup script finished!"

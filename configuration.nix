{ config, lib, pkgs, ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    /run/media/das/SSD/nixos/modules/system.nix
    /run/media/das/SSD/nixos/modules/desktop.nix
    /run/media/das/SSD/nixos/modules/users.nix
    /run/media/das/SSD/nixos/modules/packages.nix
    /run/media/das/SSD/nixos/modules/gaming.nix
    /run/media/das/SSD/nixos/modules/virtualisation.nix
  ];
}

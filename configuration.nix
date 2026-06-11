{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/gaming.nix
    ./modules/virtualisation.nix
    ./modules/vim.nix
    ./modules/bash.nix
    ./modules/home.nix
  ];
}

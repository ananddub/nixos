{ config, lib, pkgs, ... }:
{
  users.users.das = {
    isNormalUser = true;
    description = "das";
    extraGroups = [ "networkmanager" "wheel" "podman" "docker" "kvm" "libvirtd" ];
    packages = with pkgs; [];
  };

  programs.adb.enable = true;

}

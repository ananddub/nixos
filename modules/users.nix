{ config, lib, pkgs, ... }:
{
  users.users.das = {
    isNormalUser = true;
    description = "das";
    extraGroups = [ "networkmanager" "wheel" "podman" "docker" "kvm" "libvirtd" "adbusers" ];
    packages = with pkgs; [];
  };

  programs.adb.enable = true;

}

{ config, lib, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "kvm-amd" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";
  networking.extraHosts = "127.0.0.1 docker.local";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN"; LC_IDENTIFICATION = "en_IN"; LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN"; LC_NAME = "en_IN"; LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN"; LC_TELEPHONE = "en_IN"; LC_TIME = "en_IN";
  };

  # zramSwap.enable = true;
  # zramSwap.memoryPercent = 50;
  powerManagement.cpuFreqGovernor = "performance";

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ xorg.libX11 ];
  
  fileSystems."/run/media/das/SSD" = {
    device = "/dev/disk/by-uuid/1AB03937B0391AA9";
    fsType = "ntfs-3g";
    options = [ "uid=1000" "gid=100" "dmask=022" "fmask=133" "nofail" ];
  };
  fileSystems."/run/media/das/HDD" = {
    device = "/dev/disk/by-uuid/6E8EC6468EC60715";
    fsType = "ntfs-3g";
    options = [ "uid=1000" "gid=100" "dmask=022" "fmask=133" "nofail" ];
  };

  nix.nixPath = [ "nixos-config=/run/media/das/SSD/nixos/configuration.nix" "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos" ];
  system.stateVersion = "25.11";
}

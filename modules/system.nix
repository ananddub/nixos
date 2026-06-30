{ config, lib, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "kvm-amd" ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    max-jobs = "auto";
    cores = 0;
    substituters = [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSeBc=" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;

  services.earlyoom.enable = true;
  services.tailscale.enable = true;
  # services.netbird.enable = true;

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

  boot.kernel.sysctl = {
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
    "vm.vfs_cache_pressure" = 50;
    "kernel.sched_autogroup_enabled" = 1;
    "vm.max_map_count" = 2147483642;
    "kernel.perf_event_paranoid" = 1;
    "kernel.kptr_restrict" = 0;
  };

  services.irqbalance.enable = true;
  services.fstrim.enable = true;

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
  '';

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libx11 libxext libxrender libxtst libxi libxcb
    libGL zlib stdenv.cc.cc.lib libpulseaudio dbus glib libpng nss nspr
    gperftools expat libdrm libxkbfile libbsd libxcb-util libxcb-cursor
    libxcb-image libxcb-keysyms libxcb-wm libxfixes
    libsm libice fontconfig freetype pcre2 vulkan-loader
    mesa alsa-lib libxcomposite libxcursor libxdamage crun
    libxkbcommon wayland gtk3 cairo pango 
];
  

  # fileSystems."/run/media/das/SSD" = {
  #   device = "/dev/disk/by-uuid/1AB03937B0391AA9";
  #   fsType = "ntfs-3g";
  #   options = [ "uid=1000" "gid=100" "dmask=000" "fmask=000" "exec" "nofail" ];
  # };
  fileSystems."/run/media/das/SSD" = { 
    device = "/dev/disk/by-uuid/abf923dc-05ad-477f-b57f-fa06b1b67f89";                                                                     
    fsType = "ext4";                                                                                                                       
    options = [ "exec" "nofail" ];
  };

  systemd.tmpfiles.rules = [
    "d /run/media/das/SSD 0775 das users -"
  ];

  fileSystems."/run/media/das/HDD" = {
    device = "/dev/disk/by-uuid/6E8EC6468EC60715";
    fsType = "ntfs3";
    options = [ "uid=1000" "gid=100" "dmask=000" "fmask=000" "exec" "nofail" "force" ];
  };

  nix.nixPath = [ "nixos-config=/home/das/Documents/nixos/configuration.nix" "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos" ];
  system.stateVersion = "26.05";
}

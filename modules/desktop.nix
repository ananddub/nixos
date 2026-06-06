{ config, lib, pkgs, ... }:
let
  de = "gnome"; # "gnome" ya "plasma"
in
{
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb = { layout = "us"; variant = ""; };

  services.displayManager.gdm.enable = de == "gnome";
  services.desktopManager.gnome.enable = de == "gnome";

  services.displayManager.sddm.enable = de == "plasma";
  services.displayManager.sddm.wayland.enable = de == "plasma";
  services.desktopManager.plasma6.enable = de == "plasma";

  services.printing.enable = true;

  programs.dconf.enable = lib.mkIf (de == "gnome") true;
  programs.dconf.profiles.user.databases = lib.mkIf (de == "gnome") [{
    settings."org/gnome/mutter" = {
      check-alive-timeout = lib.gvariant.mkUint32 0;
      experimental-features = [ "variable-refresh-rate" "scale-monitor-framebuffer" ];
    };
  }];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
    GBM_BACKEND = "nvidia-drm";
    ANDROID_HOME = "$HOME/Android/Sdk";
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    PATH = "$HOME/Android/Sdk/emulator:$HOME/Android/Sdk/platform-tools:$PATH";
    QT_QPA_PLATFORM = "xcb";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";
    ANDROID_EMULATOR_USE_SYSTEM_LIBS = "1";
    ANDROID_EMULATOR_FORCE_GPU = "host";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  systemd.services.nvidia-performance = {
    description = "Set NVIDIA GPU to maximum performance";
    wantedBy = [ "multi-user.target" ];
    after = [ "nvidia-persistenced.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "/run/current-system/sw/bin/nvidia-smi --persistence-mode=1";
    };
  };
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [ nvidia-vaapi-driver ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}

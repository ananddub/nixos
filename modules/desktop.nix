{ config, lib, pkgs, ... }:
let
  de = "gnome"; # "gnome" ya "plasma"
in
{
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb = { layout = "us"; variant = ""; };

  services.displayManager.gdm.enable = de == "gnome";
  services.displayManager.gdm.wayland = de == "gnome";
  services.desktopManager.gnome.enable = de == "gnome";

  services.displayManager.sddm.enable = de == "plasma";
  services.displayManager.sddm.wayland.enable = de == "plasma";
  services.desktopManager.plasma6.enable = de == "plasma";

  services.printing.enable = true;

  programs.dconf.enable = lib.mkIf (de == "gnome") true;
  programs.dconf.profiles.user.databases = lib.mkIf (de == "gnome") [{
    settings."org/gnome/mutter" = {
      check-alive-timeout = lib.gvariant.mkUint32 0;
    };
  }];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    ANDROID_HOME = "$HOME/Android/Sdk";
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    PATH = "$HOME/Android/Sdk/emulator:$HOME/Android/Sdk/platform-tools:$PATH";
    QT_QPA_PLATFORM = "xcb";
    ANDROID_EMULATOR_USE_SYSTEM_LIBS = "1";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [ nvidia-vaapi-driver vulkan-loader vulkan-validation-layers ];
  hardware.graphics.extraPackages32 = with pkgs; [ vulkan-loader ];

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

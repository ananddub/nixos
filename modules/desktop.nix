{ config, lib, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb = { layout = "us"; variant = ""; };
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
  services.desktopManager.gnome.enable = true;
  services.printing.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    NVD_BACKEND = "direct";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

}

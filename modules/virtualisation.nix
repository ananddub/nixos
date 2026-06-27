{ config, lib, pkgs, ... }:
{
  virtualisation.docker = { 
    enable = true;
     enableOnBoot = true;
     daemon.settings = {
        default-runtime = "crun";

        runtimes = {
          crun = {
            path = "${pkgs.crun}/bin/crun";
          };
        };
      };
    };

  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    dockerSocket.enable = false;
  };
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
}

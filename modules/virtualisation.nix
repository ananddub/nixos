{ config, lib, pkgs, ... }:
{
  virtualisation.docker = { enable = true; enableOnBoot = true; };

  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    dockerSocket.enable = false;
  };

  virtualisation.oci-containers.containers.portainer = {
    image = "portainer/portainer-ce:latest";
    ports = [ "9443:9443" "9000:9000" ];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/var/lib/portainer:/data"
    ];
    autoStart = true;
  };
}

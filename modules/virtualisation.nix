{ config, lib, pkgs, ... }:
{
  virtualisation.podman.enable = true;
  virtualisation.docker = { enable = true; enableOnBoot = true; };

  virtualisation.oci-containers.backend = "docker";

  # Traefik - http://docker.local | dashboard: http://docker.local:8080
  virtualisation.oci-containers.containers.traefik = {
    image = "traefik:v3.0";
    ports = [ "80:80" "8080:8080" ];
    volumes = [ "/run/docker.sock:/var/run/docker.sock" ];
    extraOptions = [ "--network=traefik-net" ];
    cmd = [
      "--api.dashboard=true"
      "--api.insecure=true"
      "--entrypoints.web.address=:80"
      "--entrypoints.traefik.address=:8080"
      "--providers.docker=true"
      "--providers.docker.exposedbydefault=false"
      "--providers.docker.network=traefik-net"
    ];
    autoStart = true;
  };
  # Portainer - Docker GUI (http://docker.local)
  virtualisation.oci-containers.containers.portainer = {
    image = "portainer/portainer-ce:latest";
    volumes = [
      "/run/docker.sock:/var/run/docker.sock"
      "portainer_data:/data"
    ];
    extraOptions = [ "--network=traefik-net" ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.portainer.rule" = "Host(`docker.local`)";
      "traefik.http.routers.portainer.entrypoints" = "web";
      "traefik.http.services.portainer.loadbalancer.server.port" = "9000";
    };
    autoStart = true;
  };
}

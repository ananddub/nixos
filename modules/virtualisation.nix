{ config, lib, pkgs, ... }:
{
  virtualisation.podman.enable = true;
  virtualisation.docker = { enable = true; enableOnBoot = true; };

  virtualisation.oci-containers.backend = "docker";

  # Create traefik-net network before containers start
  systemd.services.init-traefik-net = {
    description = "Create traefik-net Docker network";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.docker}/bin/docker network inspect traefik-net >/dev/null 2>&1 || \
      ${pkgs.docker}/bin/docker network create traefik-net
    '';
  };

  # Make containers wait for network creation
  systemd.services."docker-traefik".after = [ "init-traefik-net.service" ];
  systemd.services."docker-traefik".requires = [ "init-traefik-net.service" ];
  systemd.services."docker-portainer".after = [ "init-traefik-net.service" ];
  systemd.services."docker-portainer".requires = [ "init-traefik-net.service" ];

  # Traefik - http://docker.local | dashboard: http://docker.local:8080
  virtualisation.oci-containers.containers.traefik = {
    image = "traefik:v3.0";
    ports = [ "80:80" "8080:8080" ];
    volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
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
      "/var/run/docker.sock:/var/run/docker.sock"
      "/var/lib/portainer:/data"
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

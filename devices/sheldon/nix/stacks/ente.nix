# Ente Museum API. Provision the runtime secrets described in ente/README.md.
{ lib, ... }:
let
  d = "/var/lib/stacks/ente";
in
{
  systemd.tmpfiles.rules = [
    "d ${d} 0700 root root -"
    "d ${d}/secrets 0700 root root -"
  ];

  virtualisation.oci-containers.containers = {
    ente-postgres = {
      image = "postgres:15";
      environment = {
        POSTGRES_USER = "ente";
        POSTGRES_DB = "ente";
      };
      # POSTGRES_PASSWORD must match db.password in museum.yaml.
      environmentFiles = [ "${d}/secrets/postgres.env" ];
      volumes = [ "ente-postgres-data:/var/lib/postgresql/data" ];
      extraOptions = [ "--pull=newer" ];
    };
    ente-museum = {
      image = "ghcr.io/ente-io/server:latest";
      dependsOn = [ "ente-postgres" ];
      environment = {
        ENTE_CREDENTIALS_FILE = "/run/ente/museum.yaml";
        ENTE_DB_HOST = "ente-postgres";
        ENTE_DB_PORT = "5432";
        ENTE_DB_NAME = "ente";
        ENTE_DB_USER = "ente";
      };
      volumes = [ "${d}/secrets/museum.yaml:/run/ente/museum.yaml:ro" ];
      ports = [ "127.0.0.1:8085:8080" ];
      extraOptions = [ "--pull=newer" ];
    };
  };

  # Avoid the generic bind-mount setup creating a directory for a missing secret.
  systemd.services.podman-ente-museum.preStart = lib.mkBefore ''
    test -f ${d}/secrets/museum.yaml
  '';
}

# Ente on sheldon

Museum API listens at 127.0.0.1:8085. PostgreSQL is internal, with a persistent
Podman volume `ente-postgres-data`. This module does not include Ente web apps
or an S3 server. Use an existing S3-compatible bucket, reachable by both Museum
and your Ente clients. Configure clients to use your reverse-proxied API URL.
No public firewall ports or proxy domains are added automatically.

Before activating, create `/var/lib/stacks/ente/secrets` (root-owned, mode 0700)
and the following root-owned files (mode 0600). Do not commit credentials.

`postgres.env`:

```dotenv
POSTGRES_PASSWORD=REPLACE_WITH_RANDOM_PASSWORD
```

`museum.yaml` (replace ALL placeholders):

```yaml
db:
  password: REPLACE_WITH_SAME_PASSWORD
key:
  encryption: REPLACE_WITH_BASE64_32_RANDOM_BYTES
  hash: REPLACE_WITH_BASE64_64_RANDOM_BYTES
jwt:
  secret: REPLACE_WITH_BASE64_32_RANDOM_BYTES
s3:
  b2-eu-cen:
    key: REPLACE_WITH_ACCESS_KEY
    secret: REPLACE_WITH_SECRET_KEY
    endpoint: REPLACE_WITH_S3_ENDPOINT
    region: REPLACE_WITH_REGION
    bucket: REPLACE_WITH_BUCKET
smtp:
  host: REPLACE_WITH_SMTP_HOST
  port: 587
  username: REPLACE_WITH_SMTP_USER
  password: REPLACE_WITH_SMTP_PASSWORD
  email: REPLACE_WITH_SENDER_EMAIL
  encryption: tls
```

Generate keys using `openssl rand -base64 32` (64 for the hash key).
Preserve these keys permanently and back them up with the database and bucket.
Create the bucket without object locking or versioning. Replication is disabled
by default. Configure SMTP for account verification emails.

Museum retries via the container's systemd restart policy if PostgreSQL is not
ready yet. Missing secret files prevent startup. For reproducible deployments,
replace the Museum `latest` tag with a tested immutable image digest.

This stack has only been syntax-checked, not deployed or integration-tested.

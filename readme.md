https://docs.microsoft.com/en-us/azure/devops/cli/log-in-via-pat?view=azure-devops&tabs=unix#pipe-pat-on-stdin-to-az-devops-login

echo "TOKEN" | az devops login --organization https://dev.azure.com/org



https://docs.microsoft.com/en-us/cli/azure/artifacts/universal?view=azure-cli-latest#az_artifacts_universal_download

az artifacts universal download \
  --organization "https://dev.azure.com/org/" \
  --project "23f66b24-e285-47f3-a288-633d5155edbb" \
  --scope project \
  --feed "Releases" \
  --name "mywebsitename" \
  --version "*" \
  --path .



# simple reverse proxy
- https://caddyserver.com

## Run:
caddy run --config Caddyfile





## PODMAN
test api: docker.io/containous/whoami:latest

podman pull docker.io/library/caddy

podman pod create -n myapi -p 8080:8080
podman run -dt --name api --restart unless-stopped --pod myapi docker.io/traefik/whoami:latest
podman run -dt --name proxy --restart unless-stopped --pod myapi docker.io/library/caddy:latest caddy reverse-proxy --from :8080 --to api:80
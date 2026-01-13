### Nmap

```bash
docker build -f Dockerfile -t nmap-docker:local .
```

```bash
docker build -f Dockerfile.nmap -t nmap-docker:local2 .
```

```bash
export $(grep -v '^#' .env | xargs) && docker run --rm -e HOST_UID=$(id -u) -e HOST_GID=$(id -g) -v $(pwd)/nmap-reports:/reports:rw -it nmap-docker:local $NMAP_DOMAIN
```

```bash
docker run --rm -it -v $(pwd)/nmap-reports:/reports:rw nmap-docker:local $NMAP_DOMAIN
```

docker run --rm -e HOST_UID=$(id -u) -e HOST_GID=$(id -g) -v /ruta/host/reports:/reports imagen_dominio ejemplo.com
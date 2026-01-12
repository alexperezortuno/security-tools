# NIKTO

```bash
docker build -f Dockerfile.nikto -t nikto:local .
```

```bash
export $(grep -v '^#' .env | xargs) && docker run --rm nikto:local $NIKTO_DOMAIN
```

---

```bash
docker build -f Dockerfile.nikto_ports -t nikto_ports:local .
```

```bash
export $(grep -v '^#' .env | xargs) && docker run --rm -v $(pwd)/results:/scanner/results nikto_ports:local $IP_SCAN
```
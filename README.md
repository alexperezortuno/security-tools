# security-tools
This repository has a series of scripts to detect vulnerabilities in applications and websites

## Example of usage
```bash
docker build -t owasp-scan:dev .
```

```bash
docker run --rm owasp-scan:dev https://example.com
```

### Nmap

```bash
docker build -f Dockerfile.nmap -t nmap-docker:dev .
```

```bash
docker run --rm nmap-docker example.com
```

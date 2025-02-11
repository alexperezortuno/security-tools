# security-tools
This repository has a series of scripts to detect vulnerabilities in applications and websites

## OWASP
```bash
docker build -f Dockerfile.owasp -t owasp-scan:dev .
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

### Nikto

```bash
docker build -f Dockerfile.nikto -t nikto-docker:dev .
```

```bash
docker run --rm nikto-docker example.com
```

### Sherlock

```bash
docker build -f Dockerfile.sherlock -t sherlock-docker:dev .
```

```bash
docker run --rm sherlock-docker example
```

### IP Scan

```bash
docker build -f Dockerfile.ipscan -t ipscan-docker:dev .
```

```bash
docker run --rm ipscan-docker:dev <IP>
```

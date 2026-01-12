FROM ubuntu:latest

# Instalar dependencias (sin tor)
RUN apt-get update && apt-get install -y \
    curl \
    lsof \
    traceroute \
    nmap \
    geoip-bin \
    whois \
    jq \
    proxychains4 \
    dnsutils \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

COPY ip_scan.sh /ip_scan.sh
COPY proxychains.conf.template /etc/proxychains.conf.template

RUN mkdir -p /reports && \
    chmod 755 /reports && \
    chmod +x /ip_scan.sh && \
    chown -R 1000:1000 /reports

USER 1000

ENTRYPOINT ["/ip_scan.sh"]
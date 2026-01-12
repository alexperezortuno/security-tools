# Usa la imagen oficial de OWASP ZAP desde GHCR
FROM ghcr.io/zaproxy/zaproxy:stable

# Instala dependencias necesarias
USER root
RUN apt-get update && \
    apt-get install -y curl jq && \
    rm -rf /var/lib/apt/lists/*

# Copia el script bash en el contenedor
COPY owasp_scan.sh /owasp_scan.sh

# Da permisos de ejecución al script
RUN chmod +x /owasp_scan.sh \
    && mkdir /zap/wrk

# Establece el directorio de trabajo
WORKDIR /zap

# Ejecuta el script cuando el contenedor se inicie
ENTRYPOINT ["/owasp_scan.sh"]


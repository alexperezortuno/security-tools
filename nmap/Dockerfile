FROM alpine:latest

RUN apk add --no-cache nmap ok bash bind-tools libxslt

COPY nmap_scan.sh /nmap_scan.sh

RUN chmod +x nmap_scan.sh && mkdir /reports

ENTRYPOINT ["/nmap_scan.sh"]
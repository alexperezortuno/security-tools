FROM alpine:latest

USER root

RUN apk add --no-cache bash perl perl-net-ssleay perl-io-socket-ssl git && rm -f /tmp/* /etc/apk/cache/*

RUN git clone https://github.com/sullo/nikto.git && chmod +x /nikto/program/nikto.pl

COPY nikto_scan.sh /nikto_scan.sh

RUN chmod +x nikto_scan.sh && mkdir /reports
RUN echo "alias nikto='/nikto/program/nikto.pl'" >> /etc/profile

ENTRYPOINT ["/nikto_scan.sh"]
FROM alpine:latest

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USER_NAME=appuser

RUN addgroup -g ${GROUP_ID} ${USER_NAME} && \
    adduser -u ${USER_ID} -G ${USER_NAME} -D ${USER_NAME}

RUN apk add --no-cache nmap bash bind-tools nmap-scripts libxslt

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x entrypoint.sh && mkdir /reports

ENTRYPOINT ["/entrypoint.sh"]
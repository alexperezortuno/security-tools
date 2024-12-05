FROM python:3.12-slim

# Instala dependencias necesarias
RUN apt-get update && \
    rm -rf /var/lib/apt/lists/*

RUN pip install sherlock-project

ENTRYPOINT ["sherlock"]
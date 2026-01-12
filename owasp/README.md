## OWASP
```bash
docker build -f Dockerfile -t owasp-scan:local .
```

```bash
export $(grep -v '^#' .env | xargs) && docker run --rm -v $(pwd)/owasp-reports:/zap/wrk/reports:rw owasp-scan:local $OWASP_HOST full
```
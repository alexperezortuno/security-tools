### Sherlock

```bash
docker build -f Dockerfile -t sherlock-docker:local .
```

```bash
export $(grep -v '^#' .env | xargs) && docker run --rm sherlock-docker:local $SHERLOCK_USERNAME
```
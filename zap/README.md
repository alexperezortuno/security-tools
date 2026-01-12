### ZAP Scan

```bash
docker run -v $(pwd)/zap/:/zap/wrk/:rw -t zaproxy/zap-stable zap.sh -cmd -autorun /zap/wrk/zap.yaml
```

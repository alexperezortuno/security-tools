#!/bin/bash

# Variable de la URL de destino
TARGET_URL=${1:-"http://example.com"}
TYPE_SCAN=${2:-"baseline"}

echo "Start scan OWASP ZAP in $TARGET_URL..."

case $TYPE_SCAN in
"baseline")
  echo "Running baseline scan..."
  zap-baseline.py -t "$TARGET_URL" -r reports/report.html -I
  ;;
"api")
  echo "Running API scan..."
  zap-api-scan.py -t "$TARGET_URL" -r reports/report-api.html -I
  ;;
"full")
  echo "Running full scan..."
  zap-full-scan.py -t "$TARGET_URL" -r reports/report-full.html -I
  ;;
*)
  echo "Invalid scan type. Use 'baseline', 'api' or 'full'."
  ;;
esac

#!/bin/bash

IP=$1

if [ -z "$IP" ]; then
    echo "Uso: $0 <IP>"
    exit 1
fi

echo "🔧 Configurando proxychains..."
TOR_IP=$(getent hosts tor_proxy | awk '{ print $1 }')
if [ -z "$TOR_IP" ]; then
    echo "❌ No se pudo resolver tor_proxy"
    exit 1
fi

echo "✅ Tor proxy IP: $TOR_IP"
sed "s/TOR_PROXY_IP/$TOR_IP/g" /etc/proxychains.conf.template > /tmp/proxychains.conf

# Esperar a que Tor esté disponible
echo "⏳ Esperando conexión a Tor..."
for i in {1..30}; do
    if nc -z tor_proxy 9050 2>/dev/null; then
        echo "✅ Tor está disponible en puerto 9050"
        break
    fi
    sleep 2
done

sleep 3

OUTPUT_FILE="/reports/ip_analysis_$(date +%Y%m%d_%H%M%S).txt"

{
  echo "==================================="
  echo "IP Analysis Report"
  echo "Date: $(date)"
  echo "==================================="
  echo ""

  echo "🔍 Verificando conexión a través de Tor..."
  curl -s --socks5 tor_proxy:9050 https://ifconfig.me

  echo ""
  echo "🔍 Analyzing IP: $IP ..."

  echo ""
  echo "📌 WHOIS Information:"
  proxychains4 -f /tmp/proxychains.conf whois "$IP" 2>&1 | grep -E 'OrgName|Country|NetRange'

  echo ""
  echo "🌍 Geolocation:"
  geoiplookup "$IP"

  echo ""
  echo "🛰️ Route (traceroute):"
  traceroute -n "$IP"

  echo ""
  echo "⚠️ Checking in AbuseIPDB..."
  curl -G --socks5 tor_proxy:9050 https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress=$IP" -H "Key: $ABUSEIPDB_API_KEY" | jq .

} 2>&1 | tee "$OUTPUT_FILE"

echo ""
echo "✅ Report saved in: $OUTPUT_FILE"
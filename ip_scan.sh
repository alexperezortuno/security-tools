#!/bin/bash

IP=$1

if [ -z "$IP" ]; then
    echo "Uso: $0 <IP>"
    exit 1
fi

proxychains curl -s https://ifconfig.me | grep -o "Congratulations.*"

echo "🔍 Analyzing IP: $IP ..."

echo "📌 WHOIS Information:"
proxychains whois "$IP" | grep -E 'OrgName|Country|NetRange'

echo "🌍 Geolocation:"
proxychains geoiplookup "$IP"

echo "🛰️ Route (traceroute):"
proxychains traceroute -n "$IP"

echo "🛡️ Open ports (Nmap):"
proxychains nmap -Pn -p- --min-rate=1000 "$IP"

echo "⚠️ Checking in AbuseIPDB..."
curl -G https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress=$IP" -H "Key: $ABUSEIPDB_API_KEY" | jq .

echo "✅ Analysis completed."
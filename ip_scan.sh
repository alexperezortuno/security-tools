#!/bin/bash

IP=$1

if [ -z "$IP" ]; then
    echo "Uso: $0 <IP>"
    exit 1
fi

echo "🔍 Analyzing IP: $IP ..."

echo "📌 WHOIS Information:"
whois "$IP" | grep -E 'OrgName|Country|NetRange'

echo "🌍 Geolocation:"
geoiplookup "$IP"

echo "🛰️ Route (traceroute):"
traceroute -n "$IP"

echo "🛡️ Open ports (Nmap):"
nmap -Pn -p- --min-rate=1000 "$IP"

echo "⚠️ Checking in AbuseIPDB..."
curl -G https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress=$IP" -H "Key: $ABUSEIPDB_API_KEY" | jq .

echo "✅ Analysis completed."
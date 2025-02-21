#!/bin/bash

FILE=$1
VIRUS_TOTAL=$2
ENCODE=$(sha256sum "$FILE" | awk '{print $1}')

file "$FILE"

echo "🔍 Analyzing file: $FILE ..."
echo "📌 SHA256: $ENCODE"
#curl -X GET "https://www.virustotal.com/api/v3/files/$ENCODE" -H "x-apikey: $VIRUS_TOTAL" | jq .

echo "📌 MD5: $ENCODE"
ENCODE=$(md5sum  "$FILE" | awk '{print $1}')

#curl -X GET "https://www.virustotal.com/api/v3/files/$ENCODE" -H "x-apikey: $VIRUS_TOTAL" | jq .

#clamscan -r --bell -i "$FILE"

#cat "$FILE"
#strings "$FILE"
#hexdump -C "$FILE" | head -n 20

echo "✅ Analysis completed."

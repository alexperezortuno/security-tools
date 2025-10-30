#!/bin/bash

function remove_files() {
  # remove files xml
    if ls /reports/report_"$domain"_*.xml 1> /dev/null 2>&1; then
      rm /reports/report_"$domain"_*.xml
    fi

    if ls /reports/report_"$domain"_*.nmap 1> /dev/null 2>&1; then
      rm /reports/report_"$domain"_*.nmap
    fi

    if ls /reports/report_"$domain"_*.gnmap 1> /dev/null 2>&1; then
      rm /reports/report_"$domain"_*.gnmap
    fi
}

if ls  /reports/report_"$domain"_*.html 1> /dev/null 2>&1; then
  rm /reports/report_"$domain"_*.html
fi
remove_files

# Validar entrada
if [ -z "$1" ]; then
    echo "Use: $0 <domain>"
    exit 1
fi

# Obtener la IP del dominio
domain=${1:-"example.com"}
logger -t "nmap-scan" "resolving IP $domain"
ip=$(dig +short "$domain" | head -n 1)
logger -t "nmap-scan" "IP resolved: $ip"

# Verificar si se obtuvo la IP
if [ -z "$ip" ]; then
    echo "cant resolve IP from domain $domain"
    exit 2
fi

echo "the IP of $domain is $ip"

# Ejecutar escaneos con Nmap
nmap -O "$ip" -oA /reports/report_"$domain"_1

echo "fast scan to common ports..."
nmap -sS "$ip" -oA /reports/report_"$domain"_2

echo "scan all ports..."
nmap -p- "$ip" -oA /reports/report_"$domain"_3

echo "XMAS scan..."
nmap -sX "$ip" -oA /reports/report_"$domain"_4

echo "detection of services and versions..."
nmap -sV "$ip" -oA /reports/report_"$domain"_5

echo "scan knows vulnerabilities..."
nmap --script=vuln "$ip" -oA /reports/report_"$domain"_6

echo "scan anonymous FTP..."
nmap --script ftp-anon "$ip" -oA /reports/report_"$domain"_7

# echo "Discovery scripts gather information about hosts, services, and networks"
# nmap --script dns-brute "$ip" -oA /reports/report_"$domain"_8

# echo "Exploit scripts attempt to exploit known vulnerabilities to gain access or execute code"
# nmap --script ms08-067 "$ip" -oA /reports/report_"$domain"_9

echo "These scripts interact with external resources to gather information about the target"
nmap --script ip-geolocation-geoplugin "$ip" -oA /reports/report_"$domain"_10

# echo "Fuzzing scripts are used to send a range of inputs to a service to identify unexpected behavior or crashes"
# nmap --script http-fuzz "$ip" -oA /reports/report_"$domain"_11

echo "These scripts may cause harm to the target system (e.g., crashes or disruptions). Use with caution"
nmap --script smtp-brute "$ip" -oA /reports/report_"$domain"_12

echo "Scripts in this category identify malware infections or behavior."
nmap --script http-malware-host "$ip" -oA /reports/report_"$domain"_13

echo "Safe scripts are non-intrusive and unlikely to cause any harm to the target system"
nmap --script whois-domain "$ip" -oA /reports/report_"$domain"_14

# echo "Vulnerability detection scripts look for specific vulnerabilities and report them"
# nmap --script ssl-poodle "$ip" -oA /reports/report_"$domain"_15


xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_1.xml -o /reports/report_"$domain"_1.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_2.xml -o /reports/report_"$domain"_2.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_3.xml -o /reports/report_"$domain"_3.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_4.xml -o /reports/report_"$domain"_4.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_5.xml -o /reports/report_"$domain"_5.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_6.xml -o /reports/report_"$domain"_6.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_7.xml -o /reports/report_"$domain"_7.html
#xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_8.xml -o /reports/report_"$domain"_8.html
#xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_9.xml -o /reports/report_"$domain"_9.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_10.xml -o /reports/report_"$domain"_10.html
#xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_11.xml -o /reports/report_"$domain"_11.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_12.xml -o /reports/report_"$domain"_12.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_13.xml -o /reports/report_"$domain"_13.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_14.xml -o /reports/report_"$domain"_14.html
#xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_15.xml -o /reports/report_"$domain"_15.html

#for i in {1..6}; do
#    echo "report $i"
#    cat /reports/report_"$domain"_"$i".xml > /reports/combined_report.xml
#done

#xsltproc /usr/share/nmap/nmap.xsl /reports/combined_report.xml -o /reports/combined_report.html
remove_files
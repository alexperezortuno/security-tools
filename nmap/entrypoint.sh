#!/bin/bash

HOST_UID=${HOST_UID:-1000}
HOST_GID=${HOST_GID:-1000}
HOST_USER=${HOST_USER:-appuser}

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

function change_permissions() {
  chown -R "$HOST_UID":"$HOST_GID" /reports
  chmod 644 /reports/report_"$domain"_*.html
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

nmap -p- --open -sCV -Pn -n --min-rate 5000 "$ip" -oA /reports/report_"$domain"_1
xsltproc -o /reports/report_"$domain"_1.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_1.xml

echo "initial scan completed."
nmap -O "$ip" -oA /reports/report_"$domain"_2
xsltproc -o /reports/report_"$domain"_2.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_2.xml

echo "fast scan to common ports..."
nmap -sS "$ip" -oA /reports/report_"$domain"_3
xsltproc -o /reports/report_"$domain"_3.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_3.xml

echo "scan all ports..."
nmap -p- "$ip" -oA /reports/report_"$domain"_4
xsltproc -o /reports/report_"$domain"_4.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_4.xml

echo "XMAS scan..."
nmap -sX "$ip" -oA /reports/report_"$domain"_5
xsltproc -o /reports/report_"$domain"_5.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_5.xml

echo "detection of services and versions..."
nmap -sV "$ip" -oA /reports/report_"$domain"_6
xsltproc -o /reports/report_"$domain"_6.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_6.xml

echo "scan knows vulnerabilities..."
nmap --script=vuln "$ip" -oA /reports/report_"$domain"_7
xsltproc -o /reports/report_"$domain"_7.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_7.xml

echo "scan anonymous FTP..."
nmap --script ftp-anon "$ip" -oA /reports/report_"$domain"_8
xsltproc -o /reports/report_"$domain"_8.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_8.xml


echo "Discovery scripts gather information about hosts, services, and networks"
nmap --script dns-brute "$ip" -oA /reports/report_"$domain"_9
xsltproc -o /reports/report_"$domain"_9.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_9.xml

echo "Exploit scripts attempt to exploit known vulnerabilities to gain access or execute code"
nmap --script ms08-067 "$ip" -oA /reports/report_"$domain"_10
xsltproc -o /reports/report_"$domain"_10.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_10.xml

echo "These scripts interact with external resources to gather information about the target"
nmap --script ip-geolocation-geoplugin "$ip" -oA /reports/report_"$domain"_11
xsltproc -o /reports/report_"$domain"_11.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_11.xml

echo "Fuzzing scripts are used to send a range of inputs to a service to identify unexpected behavior or crashes"
#nmap --script http-fuzz "$ip" -oA /reports/report_"$domain"_12
nmap --script=http-form-fuzzer --script-args http-form-fuzzer.maxlength=100,http-form-fuzzer.minlength=1 "$ip" -oA /reports/report_"$domain"_12
#nmap --script=http-form-fuzzer --script-args=http-form-fuzzer.maxlength=100,http-form-fuzzer.minlength=1,http-form-fuzzer.url="/login" "$ip"
xsltproc -o /reports/report_"$domain"_12.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_12.xml

echo "These scripts may cause harm to the target system (e.g., crashes or disruptions). Use with caution"
nmap --script smtp-brute "$ip" -oA /reports/report_"$domain"_13
xsltproc -o /reports/report_"$domain"_13.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_13.xml

echo "Scripts in this category identify malware infections or behavior."
nmap --script http-malware-host "$ip" -oA /reports/report_"$domain"_14
xsltproc -o /reports/report_"$domain"_14.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_14.xml

echo "Safe scripts are non-intrusive and unlikely to cause any harm to the target system"
nmap --script whois-domain "$domain" -oA /reports/report_"$domain"_15
xsltproc -o /reports/report_"$domain"_15.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_15.xml

echo "Vulnerability detection scripts look for specific vulnerabilities and report them"
nmap --script ssl-poodle "$ip" -oA /reports/report_"$domain"_16
xsltproc -o /reports/report_"$domain"_16.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_16.xml

echo "Information gathering scripts collect various types of information about the target system or network"
nmap --script=http-robots.txt "$ip" -oA /reports/report_"$domain"_17
xsltproc -o /reports/report_"$domain"_17.html /usr/share/nmap/nmap.xsl /reports/report_"$domain"_17.xml

remove_files
change_permissions

echo "Nmap scans completed. Reports are saved in /reports/"
exit 0
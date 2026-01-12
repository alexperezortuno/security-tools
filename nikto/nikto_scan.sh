#!/bin/bash

domain=${1:-"example.com"}

rm /reports/report_*.html
/nikto/program/nikto.pl -h "$domain" -C all -Format html -o /reports/report_1.html

#if [[ $domain == https* ]]; then
#  echo "The domain uses HTTPS."
#  #/nikto/program/nikto.pl -h "$domain" -p 443,8443 -ssl
#  /nikto/program/nikto.pl -h "$domain" -p "$ports"
#else
#  echo "The domain uses HTTP."
#  /nikto/program/nikto.pl -h "$domain" -p "$ports"
#fi

/nikto/program/nikto.pl -h "$domain" -id "PUT /index.html" -Format html -o /reports/report_2.html
/nikto/program/nikto.pl -h "$domain" -useragent "Nikto-Test" -C all -Format html -o /reports/report_3.html
/nikto/program/nikto.pl -h "$domain" -Tuning 1 -Format html -o /reports/report_4.html
/nikto/program/nikto.pl -h "$domain" -nointeractive -Format html -o /reports/report_5.html
#nikto -h "$domain" -vhost subdomain.example.com
/nikto/program/nikto.pl -h "$domain" -Tuning 6 -Format html -o /reports/report_6.html
/nikto/program/nikto.pl -h "$domain" -dbcheck -Format html -o /reports/report_7.html
/nikto/program/nikto.pl -h "$domain" -Plugins "apache_expect_xss" -Format html -o /reports/report_8.html
/nikto/program/nikto.pl -h "$domain" -Plugins "headers" -Format html -o /reports/report_9.html
/nikto/program/nikto.pl -h "$domain" -nointeractive -Format html -o /reports/report_10.html


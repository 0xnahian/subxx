#!/bin/bash

# Check if the target domain is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <target_domain>"
    exit 1
fi

TARGET=$1
OUTPUT_FILE="output.txt"

# Clear the output file if it exists
> $OUTPUT_FILE

# Function to execute a curl command and append results to the output file
execute_and_append() {
    local cmd="$1"
    eval "$cmd" >> $OUTPUT_FILE
}

# RapidDNS
execute_and_append "curl -s \"https://rapiddns.io/subdomain/$TARGET?full=1#result\" 2>/dev/null | grep \"<td><a\" 2>/dev/null | cut -d '\"' -f 2 2>/dev/null | grep http 2>/dev/null | cut -d '/' -f3 2>/dev/null | sed 's/#results//g' 2>/dev/null | sort -u 2>/dev/null"

# DNS BufferOver
execute_and_append "curl -s https://dns.bufferover.run/dns?q=.$TARGET 2>/dev/null | jq -r .FDNS_A[] 2>/dev/null | cut -d ',' -f2 2>/dev/null | sort -u 2>/dev/null"

# Riddler
execute_and_append "curl -s \"https://riddler.io/search/exportcsv?q=pld:${TARGET}\" 2>/dev/null | grep -Po '(([\w.-]*)\.([\w]*)\.([A-z]))\w+' 2>/dev/null | sort -u 2>/dev/null"

# VirusTotal
execute_and_append "curl -s \"https://www.virustotal.com/ui/domains/${TARGET}/subdomains?limit=40\" 2>/dev/null | grep -Po '((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+' 2>/dev/null | sort -u 2>/dev/null"

# CertSpotter
execute_and_append "curl -s \"https://certspotter.com/api/v1/issuances?domain=${TARGET}&include_subdomains=true&expand=dns_names\" 2>/dev/null | jq .[].dns_names 2>/dev/null | tr -d '[]\"\n ' 2>/dev/null | tr ',' '\n' 2>/dev/null"

# JLDC Anubis
execute_and_append "curl -s \"https://jldc.me/anubis/subdomains/${TARGET}\" 2>/dev/null | grep -Po '((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+' 2>/dev/null | sort -u 2>/dev/null"

# SecurityTrails
execute_and_append "curl -s \"https://securitytrails.com/list/apex_domain/${TARGET}\" 2>/dev/null | grep -Po '((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+' 2>/dev/null | grep '${TARGET}' 2>/dev/null | sort -u 2>/dev/null"

# Omnisint Sonar
execute_and_append "curl --silent https://sonar.omnisint.io/subdomains/$TARGET 2>/dev/null | grep -oE '[a-zA-Z0-9._-]+\.$TARGET' 2>/dev/null | sort -u 2>/dev/null"

# SynapsInt
execute_and_append "curl --silent -X POST https://synapsint.com/report.php -d 'name=https%3A%2F%2F$TARGET' 2>/dev/null | grep -oE '[a-zA-Z0-9._-]+\.$TARGET' 2>/dev/null | sort -u 2>/dev/null"

# crt.sh
execute_and_append "curl -s \"https://crt.sh/?q=%25.$TARGET&output=json\" 2>/dev/null | jq -r '.[].name_value' 2>/dev/null | sed 's/\*\.//g' 2>/dev/null | sort -u 2>/dev/null"

echo "Subdomain enumeration completed. Results saved in $OUTPUT_FILE."

#!/bin/bash

LANG=en_US.UTF-8
LANGUAGE=en_US
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC=sk_SK.UTF-8
LC_TIME=sk_SK.UTF-8
LC_COLLATE="en_US.UTF-8"
LC_MONETARY=sk_SK.UTF-8
LC_MESSAGES="en_US.UTF-8"
LC_PAPER=sk_SK.UTF-8
LC_NAME=sk_SK.UTF-8
LC_ADDRESS=sk_SK.UTF-8
LC_TELEPHONE=sk_SK.UTF-8
LC_MEASUREMENT=sk_SK.UTF-8
LC_IDENTIFICATION=sk_SK.UTF-8

function cleanup() {
	rm -f "$TEXT_TMP"
}
trap cleanup EXIT

if [ -z "$1" ]; then
	echo "Usage: $0 <pdffile>"
	exit 1
fi
payroll=$1

if [ -f "$payroll" ]; then 
	TEXT_TMP="`mktemp --tmpdir mojavyplata-parse.XXXXXX`"
	/usr/bin/pdftotext -raw "$payroll" - | sed -r -e 's/[0-9] - ([a-zA-Z].+)/\n\1/g' -e 's/[0-9] [A-Z]/\n/g' > "$TEXT_TMP"
	if grep -q 'programom HUMAN\. http://www\.hour\.sk' "$TEXT_TMP";
	then
	       	parsers/hour_software.awk < "$TEXT_TMP"
	else
		echo "Unknown format"
		exit 2
	fi
fi

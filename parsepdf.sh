#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <pdffile>"
	exit 1
fi
payroll=$1

if [ -f "$payroll" ]; then 
	/usr/bin/pdftotext -raw "$payroll" - | sed -r -e 's/[0-9] - ([a-zA-Z].+)/\n\1/g' -e 's/[0-9] [A-Z]/\n/g' | parsers/hour_software.awk
fi

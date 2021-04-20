#!/bin/sh 

# remove the string till the colon and characters other than numbers, dots, spaces and NSEW
 sed 's!^.*:\|[^0-9\. NSEW]!!g' filename |
 # calculate the latitude and longitude with some error checks
 awk '/^\s*([0-9.]+\s+){3}[NS]\s+([0-9.]+\s+){3}[EW]\s*$/ {
        lat=($1+$2/60+$3/3600); if ($4 == "S") lat=-lat;
        lon=($5+$6/60+$7/3600); if ($8 == "W") lon=-lon;
        printf("%.4f,%.4f\n", lat, lon); next  }

      { print "Error on line " NR; exit 1 }'

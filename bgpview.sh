#!/bin/bash

#
# NAME: bgpview.sh
# VERSION: v0.2
# AUTHOR: sam hill
#


# -d downstreams
# -i ipaddress
# -m my ipaddress
# -p prefixes
# -u upstreams



BOLD=$(tput bold)
NORM=$(tput sgr0)





case "$1" in

    -d)
        read -p "Enter an ASN: " asn
        echo ""
        echo "######################################"
        echo "Reference ASN: $asn"
        echo ""
        echo "${BOLD}Downstream, ASN${NORM}"
        curl -s https://api.bgpview.io/asn/$asn/downstreams |  jq '.data.ipv4_downstreams[] | "\(.name) \(.asn)"' | sed -e 's/^"//' -e 's/"$//' | awk {'print $1 "," $2'}
        echo "######################################"
        echo ""
        ;;
    -i)
        read -p "Enter an IP: " ipaddress
        echo ""
        echo "######################################"
        echo "Reference IP Address: $ipaddress"
        echo ""
        echo "${BOLD}Organization, Prefix, Country, ASN${NORM}"
        curl -s https://api.bgpview.io/ip/$ipaddress | jq '.data.prefixes[] | "\(.asn.name) \(.prefix) \(.asn.country_code) \(.asn.asn)"' | sed -e 's/^"//' -e 's/"$//' | awk {'print $1 "," $2 "," $3 "," $4'}
        echo "######################################"
        echo ""
        ;;
    -m)
        myipaddress=$(curl -s ifconfig.co)
        echo "######################################"
        echo "Reference IP Address: $ipaddress"
        echo ""
        echo "${BOLD}Organization, Prefix, Country, ASN${NORM}"
        curl -s https://api.bgpview.io/ip/$myipaddress | jq '.data.prefixes[] | "\(.asn.name) \(.prefix) \(.asn.country_code) \(.asn.asn)"' | sed -e 's/^"//' -e 's/"$//' | awk {'print $1 "," $2 "," $3 "," $4'}
        echo "######################################"
        echo ""
        ;;
    -u) 
        read -p "Enter an ASN: " asn
        echo ""
        echo "######################################"
        echo "Reference ASN: $asn"
        echo ""
        echo "${BOLD}Upstream, ASN${NORM}"
        curl -s https://api.bgpview.io/asn/$asn/upstreams |  jq '.data.ipv4_upstreams[] | "\(.name) \(.asn)"' | sed -e 's/^"//' -e 's/"$//' | awk {'print $1 "," $2'}
        echo "######################################"
        echo ""
        ;;

    -p) 
        echo ""
        echo "######################################"
        echo "Reference ASN: $asn"
        echo ""
        read -p "Enter an ASN: " asn
        echo "${BOLD}Prefix${NORM}"
        curl -s https://api.bgpview.io/asn/$asn/prefixes | jq ".data.ipv4_prefixes[] | .prefix" | sed -e 's/^"//' -e 's/"$//' 
        echo ""
        ;;

    -h) 
        echo "${BOLD} bgpview.sh usage: ${NORM}"
        echo "${BOLD} -d ${NORM} show downstream peers"
        echo "${BOLD} -i ${NORM} show ip information" 
        echo "${BOLD} -m ${NORM} show my ip information" 
        echo "${BOLD} -p ${NORM} show prefixes" 
        echo "${BOLD} -u ${NORM} show upstream peers"
        echo ""
        ;;
    *) ./bgpview.sh -h 

  esac

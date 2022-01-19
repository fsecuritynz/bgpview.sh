#!/bin/bash

#
# NAME: bgpview.sh
# VERSION: v0.1
# AUTHOR: sam hill
#


# -d downstreams
# -u upstreams
# -p prefixes


BOLD=$(tput bold)
NORM=$(tput sgr0)

clear



case "$1" in

    -d)
        read -p "Enter an ASN: " asn
        clear
        echo "Reference ASN: $asn"
        echo ""
        echo "${BOLD}Downstream, ASN${NORM}"
        curl -s https://api.bgpview.io/asn/$asn/downstreams |  jq '.data.ipv4_downstreams[] | "\(.name) \(.asn)"' | sed -e 's/^"//' -e 's/"$//' | awk {'print $1 "," $2'}
        echo ""
        ;;
    -u) 
        read -p "Enter an ASN: " asn
        clear
        echo "Reference ASN: $asn"
        echo ""
        echo "${BOLD}Upstream, ASN${NORM}"
        curl -s https://api.bgpview.io/asn/$asn/upstreams |  jq '.data.ipv4_upstreams[] | "\(.name) \(.asn)"' | sed -e 's/^"//' -e 's/"$//' | awk {'print $1 "," $2'}
        echo ""
        ;;

    -p) 
        echo ""
        clear
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
        echo "${BOLD} -u ${NORM} show upstream peers"
        echo "${BOLD} -p ${NORM} show prefixes" 
        echo ""
        ;;
    *) ./bgpview.sh -h 

  esac

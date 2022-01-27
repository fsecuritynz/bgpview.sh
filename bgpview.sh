#!/bin/bash

#
# NAME: bgpview.sh
# VERSION: v0.5
# AUTHOR: sam hill
#


# -d downstreams
# -i ipaddress
# -m my ipaddress
# -p prefixes
# -u upstreams
# -x internet exchange/s

#
# SETUP TEXT BOLD
#
BOLD=$(tput bold | tput setb 0 | tput setaf 7)
NORM=$(tput sgr0)


#
# SOFTWARE CHECK
#
if ! [ -x "$(command -v sed)" ]; then
	echo -e "\e[1;33;4;44m${BOLD}ERROR:\e[0m${NORM} \e[1;33;4;44mThe utility ${BOLD}sed${NORM} is not installed\e[0m" >&2
	exit 1
fi
if ! [ -x "$(command -v awk)" ]; then
        echo "${BOLD}ERROR:${NORM} The utility ${BOLD}awk${NORM} is not installed" >&2
        exit 1
fi
if ! [ -x "$(command -v jq)" ]; then
        echo "${BOLD}ERROR:${NORM} The utility ${BOLD}jq${NORM} is not installed" >&2
        exit 1
fi
if ! [ -x "$(command -v curl)" ]; then
        echo "${BOLD}ERROR:${NORM} The utility ${BOLD}curl${NORM} is not installed" >&2
        exit 1
fi




#
# SCRIPT
#

while getopts :d:i:u:p:x: options; do
case "$1" in

    -d)
	asn=$OPTARG
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
        ipaddress=$OPTARG
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
        asn=$OPTARG
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
    	asn=$OPTARG
        echo ""
        echo "######################################"
        echo "Reference ASN: $asn"
        echo ""
        echo "${BOLD}Prefix${NORM}"
        curl -s https://api.bgpview.io/asn/$asn/prefixes | jq ".data.ipv4_prefixes[] | .prefix" | sed -e 's/^"//' -e 's/"$//'
	echo "######################################"
        echo ""
        ;;

    -x)
        asn=$OPTARG
        echo ""
        echo "######################################"
        echo "Reference ASN: $asn"
        echo ""
        echo "${BOLD}IX Name${NORM}"
	curl -s https://api.bgpview.io/asn/$asn/ixs | jq ".data[] | .name_full"  | sed -e 's/^"//' -e 's/"$//'
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

    -h)
        echo "${BOLD} bgpview.sh usage: ${NORM}"
        echo "${BOLD} -d <<asn>> : ${NORM} show downstream peers"
        echo "${BOLD} -i <<ip-address>> : ${NORM} show ip information" 
        echo "${BOLD} -m ${NORM} : show my ip information" 
        echo "${BOLD} -p <<asn>> : ${NORM} show prefixes" 
        echo "${BOLD} -u <<asn>> : ${NORM} show upstream peers"
        echo "${BOLD} -x <<asn>> : ${NORM} show internet exchange presence"
        echo ""
        ;;

    -*) echo "${BOLD}ERROR: Unrecognized command${NORM}" >&2
	exit 2
	;;

    *) bgpview.sh -h 
	;;
  esac
done

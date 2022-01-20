# bgpview.sh
View global BGP information in bash

Leverage bgpview.io in the CLI via API to view BGP information


# Requirements
- bash
- jq
- curl
- sed
- awk

## Network Requirements
- dns & internet connectivity (https tcp/443)

# Installation
 <pre>
 sudo curl https://raw.githubusercontent.com/fsecuritynz/bgpview.sh/main/bgpview.sh >> /usr/bin/bgpview.sh
 sudo chmod +x /usr/bin/bgpview.sh
</pre>


# Operation
## Help Dialogue
<pre>
bgpview.sh -h
</pre>

## Show downstream peers
<pre>
bgpview.sh -d $asn
</pre>

## Show upstream peers
<pre>
bgpview.sh -u $asn
</pre>

## Show IP info
<pre>
bgpview.sh -i $ip-address
</pre>

## Show my ip info
<pre>
bgpview.sh -m
</pre>

## Show prefixes in an ASN
<pre>
bgpview.sh -p $asn
</pre>



# Example
<pre>
➜  ~ ./bgpview.sh -u 32787 

######################################
Reference ASN: 32787

Upstream, ASN
TWELVE99,1299
AS6453,6453
CW,1273
NTT-LTD-2914,2914
ZAYO-6461,6461
IIJ,2497
VOCUS-BACKBONE-AS,4826
INTERNEXA,BRASIL
ASN-TELSTRA-GLOBAL,4637
LEVEL3,3356
ALGAR,TELECOM
######################################


➜  ~ ./bgpview.sh -p 32787

######################################
Reference ASN: 32787

Prefix
2.17.192.0/24
2.17.192.0/22
2.17.193.0/24
2.17.194.0/24
2.17.195.0/24
...


➜  ~ ./bgpview.sh -d 32787

######################################
Reference ASN: 32787

Downstream, ASN
Locaweb,ServiiÂ¿Â½os
FITC-AS,7726
THE-BANK-OF-NEW-YORK-MELLON-CORPORATION-AS11911,11911
THE-BANK-OF-NEW-YORK-MELLON-CORPORATION-AS22260,22260
HUM-19510,19510
...
</pre>

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

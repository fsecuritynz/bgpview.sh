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
sudo curl https://raw.githubusercontent.com/fsecuritynz/bgpview.sh/main/bgpview.sh >> /usr/bin/bgpview.sh
sudo chmod +x /usr/bin/bgpview.sh

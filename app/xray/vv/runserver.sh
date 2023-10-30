#!/bin/bash

/home/ubuntu/project/sbox/app/vv/caddy reverse-proxy --from awsg.suisuy.eu.org:443 --to :80 &
/home/ubuntu/project/sbox/app/vv/v2ray -config /home/ubuntu/project/sbox/app/vv/wsserver.json

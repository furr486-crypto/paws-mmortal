#!/bin/bash

CONFIG="/etc/immortal/config.yml"
PAWS_URL=$(cat $CONFIG | grep "lab_url" | cut -d: -f2- | tr -d ' "')

echo "[$(date)] 🔥 KEEP-ALIVE ACTIVE"

while true; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$PAWS_URL" 2>/dev/null)
    echo "[$(date)] Status: $STATUS"
    
    if [ "$STATUS" = "302" ] || [ "$STATUS" = "403" ]; then
        echo "[$(date)] ⚠️ Session expired — relogin..."
        python3 /usr/local/bin/relogin.py
    fi
    
    sleep 180
done

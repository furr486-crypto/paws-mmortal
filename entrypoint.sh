#!/bin/bash

echo "🔥 PAWS IMMORTAL STARTED"

# Jalankan immortal.sh dari /usr/local/bin/
/usr/local/bin/immortal.sh &
python3 /usr/local/bin/relogin.py &

while true; do
    sleep 60
done

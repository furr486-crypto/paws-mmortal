#!/bin/bash

echo "🔥 PAWS IMMORTAL (NO-LOGS) STARTED"

# Jalankan semua di background, output ke stdout
/usr/local/bin/immortal.sh &
python3 /usr/local/bin/relogin.py &

# Keep alive
while true; do
    sleep 60
done

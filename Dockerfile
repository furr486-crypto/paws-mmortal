FROM alpine:latest

# Install dependensi sistem dan Python dalam satu lapisan
RUN apk add --no-cache bash curl python3 py3-pip jq

# Install paket Python dengan force (solusi untuk error externally-managed)
RUN pip3 install requests pyyaml flask --break-system-packages

# Salin semua file skrip dan konfigurasi
COPY *.sh /usr/local/bin/
COPY *.py /usr/local/bin/
COPY config.yml /etc/immortal/config.yml

# Beri izin eksekusi pada semua skrip shell
RUN chmod +x /usr/local/bin/*.sh

# Salin dan atur entrypoint utama
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Tentukan entrypoint
ENTRYPOINT ["/entrypoint.sh"]

FROM alpine:latest

RUN apk add --no-cache bash curl python3 py3-pip jq
RUN pip3 install requests pyyaml flask --break-system-packages

# Copy file utama
COPY entrypoint.sh /entrypoint.sh
COPY config.yml /etc/immortal/config.yml

# Copy script dari folder scripts/
COPY scripts/ /usr/local/bin/

RUN chmod +x /entrypoint.sh
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/entrypoint.sh"]

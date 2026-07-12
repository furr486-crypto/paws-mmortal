FROM alpine:latest

RUN apk add --no-cache bash curl python3 py3-pip jq
RUN pip3 install requests pyyaml flask

COPY *.sh /usr/local/bin/
COPY *.py /usr/local/bin/
COPY config.yml /etc/immortal/config.yml

RUN chmod +x /usr/local/bin/*.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

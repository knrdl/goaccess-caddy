FROM alpine:3.19.0

RUN apk add --no-cache caddy goaccess
COPY Caddyfile entrypoint.sh /
RUN chmod +x /entrypoint.sh
COPY index.html /www/index.html

EXPOSE 3000 8080
ENTRYPOINT [ "/entrypoint.sh" ]
VOLUME /log /cache
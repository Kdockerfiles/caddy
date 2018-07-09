FROM alpine:3.8

RUN apk add --no-cache curl

RUN curl -Lo - "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=off" | tar xz -C /home caddy


FROM alpine:3.8
LABEL maintainer="KenjiTakahashi <kenji.sx>"

RUN apk add --no-cache ca-certificates

COPY --from=0 /home/caddy /home/caddy

ENV CADDYPATH=/home/data/certs

VOLUME /home/data

EXPOSE 80 443

ENTRYPOINT ["/home/caddy", "--conf", "/home/data/Caddyfile"]
CMD ["--log", "stdout"]

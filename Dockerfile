FROM alpine

ENV LETSE_VERSION 1.0.0

RUN apk update && apk add \
    openssl \
    curl \
    bash \
    && rm -rf /var/cache/apk/*
RUN curl -fSL https://github.com/c4milo/letse/releases/download/v${LETSE_VERSION}/letse_v${LETSE_VERSION}_linux_amd64.tar.gz \
-o letse_v${LETSE_VERSION}_linux_amd64.tar.gz && tar -xzvf letse_v${LETSE_VERSION}_linux_amd64.tar.gz && mv letse /usr/local/bin/ && rm letse_v${LETSE_VERSION}_linux_amd64.tar.gz

COPY gen_certs.sh /gen_certs.sh

VOLUME ["/root/.aws", "/etc/certs"]

ENTRYPOINT ["/gen_certs.sh"]

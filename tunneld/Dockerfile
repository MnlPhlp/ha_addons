FROM alpine

ARG ARCH

# download the matching tarball
RUN if [ "$ARCH" == "AMD64" ]; then \
        curl -L https://github.com/mmatczuk/go-http-tunnel/releases/download/2.1/tunnel_linux_amd64.tar.gz > tunnel.tar.gz;\
    else \
        apk add curl && \
        curl -L https://github.com/mmatczuk/go-http-tunnel/releases/download/2.1/tunnel_linux_arm.tar.gz > tunnel.tar.gz;\
    fi &&\
    ls
# extract the server binary
RUN tar xvf tunnel.tar.gz &&\
    rm -f tunnel.tar.gz tunnel &&\
    mkdir .tunneld
# install json parser and openssl
RUN apk add jq openssl
# setup start script
COPY scripts/haEntrypoint.sh /scripts/haEntrypoint.sh
CMD ["/scripts/haEntrypoint.sh"]
    
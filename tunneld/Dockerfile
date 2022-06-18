FROM alpine

ARG TARGETARCH

# download the matching tarball
RUN if [ "$ARCH" == "AMD64" ]; then \
        wget https://github.com/mmatczuk/go-http-tunnel/releases/download/2.1/tunnel_linux_arm.tar.gz -O tunnel.tar.gz;\
    else \
        wget https://github.com/mmatczuk/go-http-tunnel/releases/download/2.1/tunnel_linux_amd64.tar.gz -O tunnel.tar.gz;\
    fi &&\
    ls
# extract the server binary
RUN tar xvf tunnel.tar.gz &&\
    rm -f tunnel.tar.gz tunnel &&\
    mkdir .tunneld
# setup start script
COPY scripts/haEntrypoint.sh /scripts/haEntrypoint.sh
CMD ["/scripts/haEntrypoint.sh"]
    
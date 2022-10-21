FROM debian
ARG TARGETARCH

RUN echo "TARGETARCH: $TARGETARCH"
# download the matching binary
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y wget unzip
RUN echo $TARGETARCH > architecture.log
RUN wget https://download.pydio.com/latest/cells/release/%7Blatest%7D/linux-$TARGETARCH/pydio-cells-%7Blatest%7D-linux-$TARGETARCH.zip -O cells.zip
RUN unzip cells.zip

FROM debian
# install json parser
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y jq &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* 
# copy the binary from the build stage
COPY --from=0 /cells /bin/cells

COPY scripts scripts

ENTRYPOINT [ "./scripts/haEntrypoint.sh" ,"cells", "start"]
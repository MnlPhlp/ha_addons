FROM debian AS build_stage

ARG TARGETARCH

RUN echo "TARGETARCH: $TARGETARCH"
# download the matching binary
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y wget unzip &&\
    if [ "$TARGETARCH" == "arm64" ]; then \
    wget https://download.pydio.com/latest/cells/release/%7Blatest%7D/linux-arm64/pydio-cells-%7Blatest%7D-linux-arm64.zip -O cells.zip;\
    else \
    wget https://download.pydio.com/latest/cells/release/%7Blatest%7D/linux-amd64/pydio-cells-%7Blatest%7D-linux-amd64.zip -O cells.zip;\
    fi &&\
    unzip cells.zip

FROM debian
# install json parser
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y jq &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* 
# copy the binary from the build stage
COPY --from=build_stage /cells /bin/cells

COPY scripts scripts

ENTRYPOINT [ "./scripts/haEntrypoint.sh" ,"cells", "start"]
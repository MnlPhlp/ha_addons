FROM seafileltd/seafile-mc:9.0.2

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# map /shared to /data to make it persistent
RUN ln -s /data /shared

# install jq to parse config
RUN apt-get update && apt-get install -y -f --no-install-recommends jq

# overwrite setup scripts to enable use of existing db user from env
COPY scripts/setup-seafile-mysql.py /opt/seafile/seafile-server-9.0.2/setup-seafile-mysql.py
COPY scripts/utils.py /scripts/utils.py
COPY scripts/bootstrap.py /scripts/bootstrap.py

# fix nginx conf
COPY templates/seafile.nginx.conf.template /templates/seafile.nginx.conf.template

# overwrite start script to use config from home assistant
COPY scripts/haEntrypoint.sh /scripts/haEntrypoint.sh
CMD ["/scripts/haEntrypoint.sh"]

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="mnlphlp <online@manuel.sh>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="mnlphlp" \
    org.opencontainers.image.authors="mnlphlp <online@manuel.sh>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/MnlPhlp/ha_addons" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/MnlPhlp/ha_addons/tree/master#readme" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

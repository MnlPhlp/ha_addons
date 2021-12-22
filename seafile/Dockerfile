FROM seafileltd/seafile-mc:9.0.2

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
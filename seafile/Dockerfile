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

# modify sql scripts to drop and recreate tables so a reinstall starts with new data
RUN sed -i 's/^CREATE TABLE `\([^ ]*\)/DROP TABLE IF EXISTS `\1;\n&/' seafile-server-9.0.2/seahub/sql/mysql.sql
RUN sed -i 's/^CREATE TABLE IF NOT EXISTS `\([^ ]*\)/DROP TABLE IF EXISTS `\1;\n&/' seafile-server-9.0.2/seahub/sql/mysql.sql
RUN sed -i 's/^CREATE TABLE IF NOT EXISTS \([^ ]*\)/DROP TABLE IF EXISTS \1;\n&/' seafile-server-9.0.2/sql/mysql/ccnet.sql
RUN sed -i 's/^CREATE TABLE IF NOT EXISTS \([^ ]*\)/DROP TABLE IF EXISTS \1;\n&/' seafile-server-9.0.2/sql/mysql/seafile.sql

# overwrite start script to use config from home assistant
COPY scripts/haEntrypoint.sh /scripts/haEntrypoint.sh
CMD ["/scripts/haEntrypoint.sh"]
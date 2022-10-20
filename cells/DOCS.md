# mnlphlo/ha_addons: Seafile

## Installation
Follow these steps to get the add-on installed on your system:
1. open your Add-on Store
2. open repository list (menu on the top right -> repositories)
3. add https://github.com/MnlPhlp/ha_addons
4. Reload
5. Find the addon in the Add-on Store and click install

## Usage
> This addon requires a mysql database. You can use the [MariaDb Addon](https://github.com/home-assistant/addons/blob/master/mariadb/DOCS.md)

You need to create three databases and a user to access them. The databases have to be called:
- ccnet_db
- seafile_db
- seahub_db
When using the MariaDb Addon the config for the addon looks something like this:
```yaml
# example config for MariaDb
databases:
  - ccnet_db
  - seafile_db
  - seahub_db
logins:
  - password: seafilePass
    username: seafile
rights:
  - database: ccnet_db
    username: seafile
  - database: seafile_db
    username: seafile
  - database: seahub_db
    username: seafile
```
You then need to configure the Seafile addon to use this database and user. `db` specifies the database host, which for the MariaDb addon is `core-mariadb`. The `admin_email` and `admin_pass` values are used to create an initial admin user for the seafile instance.
```yaml
# example config for seafile
db: core-mariadb
db_user: seafile
db_pass: puwiDi4WSg8TqX
tz: Europe/Berlin
admin_email: sea@file.com
admin_pass: seafile
server_hostname: hassio.local
```
After configuring all of the start the Addon and click OPEN WEB UI to open the seafile login page.
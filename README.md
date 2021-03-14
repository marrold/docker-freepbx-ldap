# docker-freepbx-ldap

docker-freepbx-ldap is a lightweight container for running [freepbx-ldap](https://github.com/a1comms/freepbx-ldap) - "A simple LDAP server to serve a searchable address book of internal extensions from the FreePBX DB"

## Caveats

There is currently no authorisation - any device attempting to bind to freepbx-ldap will be successful and results are sent in the clear. It's assumed the directory is either public or protected by other means, e.g it's running on the local network.

## Usage

The container is simple to use and stateless, it just operates as a "shim" between LDAP directory requests and the underlying FreePBX database. It listens on port 10389/tcp and when it gets a directory request from a phone it will query the relevant user and telephone number from the database.

## docker-compose

It's assumed you will use Docker Compose to run the container.

### Environment Variables

| Variable |Purpose  |
|--|--|
| PUID | The User ID to run Bind |
| GUID | The Group ID to run Bind |
| TZ | The local timezone |
| FREEPBX_SQLSERVER | The server to connect to. Defaults to "127.0.0.1:3306" |
| FREEPBX_SQLUSER | The username to use. Defaults to "root" |
| FREEPBX_SQLPASS | The password to use. Defaults to "" |
| FREEPBX_SQLDB | The database to use. Defaults to "asterisk" |

### docker-compose.yaml

An example `docker-compose.yml` file can be found below.

    ---
    version: "3.2"
    services:
      freepbx-ldap:
        image: index.docker.io/marrold/docker-freepbx-ldap:latest
        container_name: freepbx-ldap
        environment:
          - PUID=5001
          - PGID=5001
          - TZ=Europe/London
          - FREEPBX_SQLSERVER="10.8.1.8:3306"
          - FREEPBX_SQLUSER="admin"
          - FREEPBX_SQLPASS="password"
          - FREEPBX_SQLDB="freepbx"
        ports:
          - 10389:10389/tcp
        restart: unless-stopped

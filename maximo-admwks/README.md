# Build IBM Maximo Administration Workstation container

Example

```bash
cd ../maximo-admwks

podman build -t maximo-admwks/maximo-admwks:1.0  .
```

# Build maximo.ear

## Build maximo.ear for a Oracle Database and Weblogic

```bash
podman run -it --rm \
  -v "$(pwd)":/resources \
  -e MX_DB_VENDOR=Oracle \
  -e MX_DB_HOSTNAME=orcl.maximo.com -e MX_DB_PORT=1521 \
  -e MX_DB_USER=maximo -e MX_DB_PASSWORD=passw0rd \
  -e MX_DB_SCHEMA=maximo -e MX_DB_NAME=maxdb.maximo.com \
  -e MX_APP_VENDOR=weblogic \
  maximo-admwks/maximo-admwks:1.0
```

## Build maximo.ear for a DB2 Database and WAS

```bash
podman run -it --rm \
  -v "$(pwd)":/resources \
  -e MX_DB_VENDOR=DB2 \
  -e MX_DB_HOSTNAME=db2.maximo.com -e MX_DB_PORT=50000 \
  -e MX_DB_USER=ctginst1 -e MX_DB_PASSWORD=passw0rd -e MX_DB_NAME=maxdb76 \
  -e MX_APP_VENDOR=was \
  maximo-admwks/maximo-admwks:1.0
```

## Build maximoXXX.war for DB2 and Liberty

```bash
podman run -it --rm \
  -v "$(pwd)":/resources \
  -e MX_DB_VENDOR=DB2 \
  -e MX_DB_HOSTNAME=db2.maximo.com -e MX_DB_PORT=50005 \
  -e MX_DB_USER=maximo -e MX_DB_PASSWORD=passw0rd -e MX_DB_NAME=MAXDB76 \
  -e MX_APP_VENDOR=liberty \
  maximo-admwks/maximo-admwks:1.0
```

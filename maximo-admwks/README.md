# Build IBM Maximo 7.6.1.0 image

Example

```bash
cd ../maximo-admwks

podman build -t maximo-admwks/maximo-admwks:1.0  .
```


## Arguments:

## Environment Variables:

###  Oracle Database:
```
 * MX_DB_VENDOR Oracle
 * MX_DB_HOSTNAME orcl.maximo.com
 * MX_DB_PORT 1521
 * MX_DB_USER maximo
 * MX_DB_PASSWORD maximo
 * MX_DB_SCHEMA maximo
 * MX_DB_NAME maxdb.maximo.com
 * MX_DB_URL maxdb.maximo.com
```

###  DB2 Database:
```
* MX_DB_VENDOR DB2
* MX_DB_HOSTNAME db2.maximo.com
* MX_DB_PORT 50005
* MX_DB_USER maximo
* MX_DB_PASSWORD maximo
* MX_DB_NAME MAXDB76
```


### MX_APP_VENDOR

* MX_APP_VENDOR=weblogic

Build for Oracle Weblogic

* MX_APP_VENDOR=was

Build for IBM WebSphere Application Server

* MX_APP_VENDOR=liberty

Build for IBM Liberty Profile

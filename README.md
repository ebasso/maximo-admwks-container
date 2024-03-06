# IBM Maximo Administrative Workstation as Container

The IBM Maximo Administrative Workstation is the system where IBM Maximo is installed. It is used to apply new fix packs, feature packs, addons, industry solutions, or any customizations are applied to the installed IBM Maximo code. 

The IBM Maximo Administrative Workstation project as a Docker/Podman Container has the function of generating the .ear/.war files to deploy the application in an automated way to be used in a CI/CD pipeline.

To create our maximo-admwks-container, we have some temporary stages, before generating the final image, as I describe below:

1) In the first stage, we install IBM Installation Manager
2) In the second stage, we install IBM Maximo EAM 7.6.1.0, using the previous image "maximo-admwks/ibm-im:1.9"
3) In the third stage, we apply the 7.6.1.3 fix, using the previous image "maximo-admwks/maximo-smp:7.6.1.0"
4) (Optional) at this stage we apply some iFix, in my case iFix 7.6.1.3 ifix 12, using the previous image "maximo-admwks/maximo-smp:7.6.1.3"
5) In order to reduce the size of the image, we created the maximo-admwks-container by copying only the /opt/IBM/SMP directory from the previous image.

At the end you will be able to remove the images from stages 1, 2, 3 and 4.

## Building IBM Maximo Asset Management V7.6.1.x images by manually

1. Download IBM Installation Manager, IBM Maximo 7.6.1.0, IBM Maximo 7.6.1.2/3, ... and add to a directory

* agent.installer.linux.gtk.x86_64_1.9.zip
* MAM_7.6.1.0_LINUX64.tar.gz
* MAMMTFP7612IMRepo.zip
* MAMMTFP7613IMRepo-signed.zip
* maximomobile-8.9.zip (pre-req Maximo 7.6.1.3)

2. Create docker network for build, using command:
```bash
docker network create build
```

3. Run nginx docker image to be able to download binaries from HTTP.
```bash
docker run --name maximo-images -h maximo-images --network build  \
  -v "$(pwd)":/usr/share/nginx/html:ro  \
  -d nginx
```

4. Clone this repository.
```bash
git clone https://github.com/ebasso/maximo-admin-wks-docker.git
```

5. Move to the directory.
```bash
cd maximo-admin-wks-docker
```

6. Build IBM Installation Manager image:
```bash
cd ibm-im

docker build -t maximo-admwks/ibm-im:1.9 --build-arg url="http://maximo-images"  \
  --network build  .
```

7. Build IBM Maximo 7.6.1.0 image:
```bash
cd ../maximo-smp

docker build -t maximo-admwks/maximo-smp:7.6.1.0 --build-arg url="http://maximo-images"  \
  --network build  .
```

8. Build IBM Maximo FixPack 7.6.1.3:
```bash
cd ../maximo-smp-7613

docker build -t maximo-admwks/maximo-smp-fp:7.6.1.3 --build-arg url="http://maximo-images"  \
  --network build  .
```

Version 7.6.1.2 is also available in the repository, just change the 3 to the 2 in the commands above.


# Build maximo.ear

## Build maximo.ear for a Oracle Database and Weblogic

```bash
docker run -it --rm \
  -v "$(pwd)":/resources \
  -e MX_DB_VENDOR=Oracle \
  -e MX_DB_HOSTNAME=orcl.maximo.com \
  -e MX_DB_PORT=1521 \
  -e MX_DB_USER=maximo \
  -e MX_DB_PASSWORD=passw0rd \
  -e MX_DB_SCHEMA=maximo \
  -e MX_DB_NAME=maxdb.maximo.com \
  -e MX_APP_VENDOR=weblogic \
  maximo-admwks/maximo-smp-fp:7.6.1.3
```

## Build maximo.ear for a DB2 Database and WAS

```bash
docker run -it --rm \
  -v "$(pwd)":/resources \
  -e MX_DB_VENDOR=DB2 \
  -e MX_DB_HOSTNAME=db2.maximo.com \
  -e MX_DB_PORT=50005 \
  -e MX_DB_USER=maximo \
  -e MX_DB_PASSWORD=passw0rd \
  -e MX_DB_NAME=MAXDB76 \
  -e MX_APP_VENDOR=was \
  maximo-admwks/maximo-smp-fp:7.6.1.3
```

## Build maximoXXX.war for DB2 and Liberty

```bash
docker run -it --rm \
  -v "$(pwd)":/resources \
  -e MX_DB_VENDOR=DB2 \
  -e MX_DB_HOSTNAME=db2.maximo.com \
  -e MX_DB_PORT=50005 \
  -e MX_DB_USER=maximo \
  -e MX_DB_PASSWORD=passw0rd \
  -e MX_DB_NAME=MAXDB76 \
  -e MX_APP_VENDOR=liberty \
  maximo-admwks/maximo-smp-fp:7.6.1.3
```

## Acknowledgments

This project was inspired by the [Docker images for IBM Maximo Asset Management V7.6.1 with Liberty done by Nish2Go](https://github.com/nishi2go/maximo-liberty-docker). Some parts were used from his project. My sincere thanks to Nish2Go.

## License

This project is licensed under Apache 2.0 license.

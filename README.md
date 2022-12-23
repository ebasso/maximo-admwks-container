# IBM Maximo Administrative Workstation on Docker Container

The IBM Maximo Administrative Workstation is the system where IBM Maximo is installed. It is used to apply new fix packs, feature packs, addons, industry solutions, or any customizations are applied to the installed IBM Maximo code. 

The IBM Maximo Administrative Workstation project as a Docker Container has the function of generating the .ear/.war files to deploy the application in an automated way, that is, to be used in a CI/CD pipeline.


## Building IBM Maximo Asset Management V7.6.1.x images by manually

1. Download IBM Installation Manager, IBM Maximo 7.6.1.0, IBM Maximo 7.6.1.2/3, ... and add to a directory

* agent.installer.linux.gtk.x86_64_1.9.2.2.zip
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
    docker run --name maximo-images -h maximo-images --network build -v "$(pwd)":/usr/share/nginx/html:ro -d nginx
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

    docker build -t maximo-admwks/ibm-im:1.9 --build-arg url="http://maximo-images" --network build  .
    ```

7. Build IBM Maximo 7.6.1.0 image:
    ```bash
    cd ../maximo-smp

    docker build -t maximo-admwks/maximo-smp:7.6.1.0 --build-arg url="http://maximo-images" --network build  .
    ```

8. Build IBM Maximo FixPack 7.6.1.3:
    ```bash
    cd ../maximo-smp-7613

    docker build -t maximo-admwks/maximo-smp-fp:7.6.1.3 --build-arg url="http://maximo-images" --network build  .
    ```

Version 7.6.1.2 is also available in the repository, just change the 3 to the 2 in the commands above.


## Build maximo.ear

    ```bash
    docker run -it --rm -v /maximo-admwks-docker/maximo-smp/resources:/resources maximo-admwks/maximo-smp-fp:7.6.1.3
    ```
    


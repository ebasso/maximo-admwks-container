# Build IBM Maximo 7.6.1.2 image

Example

```bash
cd ../maximo-smp

podman build -t maximo-admwks/maximo-smp:7.6.1.2 --build-arg url="http://<IP_SERVER>"   .
```


## Arguments:

* **URL to IBM Maximo binaries**

```bash
 --build-arg url="http://<IP_SERVER>"
```

* **IBM Maximo EAM 7.6.1.2 binary**

```bash
 --build-arg mam_image=MAMMTFP7612IMRepo.zip
```


# Build IBM Maximo 7.6.1.0 image

Example

```bash
cd ../maximo-smp

docker build -t maximo-admwks/maximo-smp:7.6.1.0 --build-arg url="http://maximo-images" --network build  .
```


## Arguments:

* **URL to IBM Maximo binaries**

```bash
 --build-arg url="http://maximo-images"
```

* **IBM Maximo EAM 7.6.1.0 binary**

```bash
 --build-arg mam_image=MAM_7.6.1.0_LINUX64.tar.gz
```


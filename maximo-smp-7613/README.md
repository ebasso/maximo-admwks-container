# Build IBM Maximo 7.6.1.3 image

Example

```bash
cd ../maximo-smp

docker build -t maximo-admwks/maximo-smp:7.6.1.3 --build-arg url="http://maximo-images" --network build  .
```


## Arguments:

* **URL to IBM Maximo binaries**

```bash
 --build-arg url="http://maximo-images"
```

* **IBM Maximo EAM 7.6.1.3 binary**

```bash
 --build-arg mam_image=MAMMTFP7613IMRepo-signed.zip
```


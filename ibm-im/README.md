# Build IBM Installation Manager image

Example

```bash
cd ibm-im

docker build -t maximo-admwks/ibm-im:1.9 --build-arg url="http://maximo-images" --network build  .
```


Where:

### URL to IBM Maximo binaries

```bash
 --build-arg url="http://maximo-images"
```

### IBM Installation Manager binary

```bash
 --build-arg im_image=agent.installer.linux.gtk.x86_64_1.9.2.2.zip
```


# Build IBM Installation Manager image

Example

```bash
cd ibm-im

podman build -t maximo-admwks/ibm-im:1.9 --build-arg url="http://<IP_SERVER>"   .
```


## Arguments:

* **URL to IBM Maximo binaries**

```bash
 --build-arg url="http://<IP_SERVER>"
```

* **IBM Installation Manager binary**

```bash
 --build-arg im_image=agent.installer.linux.gtk.x86_64_1.9.3.zip
```


# Build IBM Maximo 7.6.1.3 image

Example

```bash
cd ../maximo-smp

podman build -t maximo-admwks/maximo-smp:7.6.1.3 --build-arg url="http://<IP_SERVER>"   .
```


## Arguments:

* **URL to IBM Maximo binaries**

```bash
 --build-arg url="http://<IP_SERVER>"
```

* **IBM Maximo EAM 7.6.1.3 binary**

```bash
 --build-arg mam_image=MAMMTFP7613IMRepo-signed.zip
```


* **IBM Maximo EAM 7.6.1.3 ifix binary**

Before

1. Download the interim fix from Fix Central.

2. Create a new directory and extract the interim fix in the new directory. 

```bash
unzip TPAE_7613_IFIX.20230914-0042.im.zip 
```

3. Open the repository.xml file and get the fix id. For Example:

```xml
<fix id='com.ibm.tivoli.tpae.base.mam.main.20160329-1545' version='7.6.0.0' offeringId='com.ibm.tivoli.tpae.base.mam.main' offeringVersion='7.6.0.0'>
```

4. Copy TPAE_7613_IFIX.20230914-0042.im.zip to http server

Now you can add the following to 

```bash
podman build -t maximo-admwks/maximo-smp:7.6.1.3 --build-arg url="http://<IP_SERVER>" \
 --build-arg ifix=20230914-0042 --build-arg mam_ifix_image=TPAE_7613_IFIX.20230914-0042.im.zip .
```

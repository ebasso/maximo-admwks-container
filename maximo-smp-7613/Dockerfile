FROM maximo-admwks/maximo-smp:7.6.1.0

ARG fp=3
ARG url=http://files
ARG mam_fp_image=MAMMTFP761${fp}IMRepo-signed.zip

ARG ifix=20230914-0042
ARG url=http://files
#ARG mam_fp_image=TPAE_7613_IFIX.${ifix}.im.zip
ARG mam_ifix_image=default_value

ENV TEMP /tmp
WORKDIR /tmp

ENV BYPASS_PRS=True

# Install Maximo V7.6.1.x feature pack
RUN wget -q -O mam_fp_repo.zip $url/$mam_fp_image && sleep 10 \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl -log /opt/IBM/mam_fp_install.log -acceptLicense \
 install com.ibm.tivoli.tpae.base.mam.main -repositories /tmp/mam_fp_repo.zip -installationDirectory /opt/IBM/SMP  \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl -log /opt/IBM/mam_fp_install2.log -acceptLicense \
 install com.ibm.tivoli.tpae.base.tpae.main -repositories /tmp/mam_fp_repo.zip -installationDirectory /opt/IBM/SMP  \
 && rm -fr /tmp/*


# Check if arg2 is provided
RUN if [ "$mam_ifix_image" != "default_value" ]; then \
      wget -q -O mam_ifix_image.zip $url/$mam_ifix_image && sleep 10 \
      && /opt/IBM/InstallationManager/eclipse/tools/imcl -log /opt/IBM/mam_ifix_install.log -acceptLicense \
        install com.ibm.tivoli.tpae.base.tpae.main.$ifix -repositories /tmp/mam_ifix_image.zip -installationDirectory /opt/IBM/SMP  \
       && rm -fr /tmp/*  
    fi
FROM maximo-admwks/maximo-smp:7.6.1.0

ARG fp=2
ARG url=http://images
ARG mam_fp_image=MAMMTFP761${fp}IMRepo.zip

ENV TEMP /tmp
WORKDIR /tmp

ENV BYPASS_PRS=True

# Install Maximo V7.6.1.x feature pack
RUN wget -q -O mam_fp_repo.zip $url/$mam_fp_image && sleep 10 \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl -log /opt/IBM/mam_fp_install.log -acceptLicense \
 install com.ibm.tivoli.tpae.base.mam.main -repositories /tmp/mam_fp_repo.zip -installationDirectory /opt/IBM/SMP  \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl -log /opt/IBM/mam_fp_install2.log -acceptLicense \
 install com.ibm.tivoli.tpae.base.tpae.main -repositories /tmp/mam_fp_repo.zip -installationDirectory /opt/IBM/SMP  \
 && rm -fr *

 ENTRYPOINT ["/work/builder.sh"]
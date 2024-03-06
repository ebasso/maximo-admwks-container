FROM maximo-admwks/ibm-im:1.9

ARG url=http://files
ARG mam_image=MAM_7.6.1.0_LINUX64.tar.gz

ENV TEMP /tmp
WORKDIR /tmp
WORKDIR /Launchpad

ENV BYPASS_PRS=True

## Install Maximo V7.6.1
RUN wget -q -O mam76.tar $url/$mam_image \
 && tar -xpf mam76.tar \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl -log /opt/IBM/mam_install.log -acceptLicense \
 -input /Launchpad/SilentResponseFiles/Unix/ResponseFile_MAM_Install_Unix.xml \
 && mkdir -p /opt/IBM/SMP/maximo/deployment/default \
 && rm -rf /tmp/*

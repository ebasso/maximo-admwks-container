FROM registry.access.redhat.com/ubi8/ubi

ARG url=http://files
ARG iim_image=agent.installer.linux.gtk.x86_64_1.9.zip

ENV TEMP /tmp
WORKDIR /tmp

# Install required packages
RUN dnf -y update && dnf -y install curl wget unzip

# Install IBM Installation Manager 1.9
RUN mkdir -p /opt/IBM \
 && wget -q -O iim.zip $url/$iim_image  \
 && unzip iim.zip \
 && ./installc -log /opt/IBM/im_install.log -acceptLicense \
 && rm -rf *
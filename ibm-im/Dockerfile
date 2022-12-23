FROM ubuntu:18.04

ARG url=http://files
ARG iim_image=agent.installer.linux.gtk.x86_64_1.9.2.2.zip

ENV TEMP /tmp
WORKDIR /tmp

# Install required packages
RUN apt update && apt install -y curl wget unzip netcat inetutils-ping gettext-base && rm -rf /var/lib/apt/lists/*

# Install IBM Installation Manager 1.8.8
RUN mkdir -p /opt/IBM \
 && wget -q -O iim.zip $url/$iim_image  \
 && unzip iim.zip \
 && ./installc -log /opt/IBM/im_install.log -acceptLicense \
 && rm -rf *
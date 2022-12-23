FROM maximo-admwks/maximo-smp-fp:7.6.1.3

ARG fp=8.9
ARG url=http://images
ARG mob_image=maximo-mobile${fp}.zip

ENV TEMP /tmp
WORKDIR /opt/IBM/SMP/maximo

ENV BYPASS_PRS=True

# Install Maximo Mobile
RUN wget -q -O mam_mobile.zip $url/$mob_image \
 && unzip mam_mobile.zip \
 && rm mam_mobile.zip